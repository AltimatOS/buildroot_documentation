#!/usr/bin/env perl

#   Copyright 2020, YggdrasilSoft, LLC.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

package main {
    use strict;
    use warnings;
    use utf8;
    use English;

    use feature ":5.26";
    no warnings "experimental::signatures";
    no warnings "experimental::smartmatch";
    use feature "lexical_subs";
    use feature "signatures";

    use FindBin;
    use lib "$FindBin::Bin/../lib";

    use boolean qw(:all);
    use File::Tools qw(:all);
    use Getopt::Long qw(:config gnu_compat);
    use JSON5;
    use Term::ANSIColor;
    use Throw qw(throw classify);
    use Try::Tiny qw(try catch);

    use File::IO;
    use Sys::Error;

    use AltimatOS::Application::Error;

    # some globals
    my $color_output = false;
    my $config_json  = undef;
    my $pkg          = undef;
    my $stage        = undef;
    my $VERSION      = '1.0.0';

    my $app_error    = AltimatOS::Application::Error->new();
    my $error        = Sys::Error->new();

    my sub read_json ($path, $params) {
        my $fh = undef;
        my $fc = undef;
        my $status = ();

        my $schema_type    = $params->{'type'};
        my $schema_version = $params->{'version'};

        my $fio = File::IO->new();
        ($fh, $status) = $fio->open('r', $path);
        ($fc, $status) = $fio->read($fh, -s $fh);
        $status = $fio->close($fh);

        my $struct = {};
        try {
            my $json = JSON5->new();
            $struct = $json->decode($fc);
        } catch {
            classify(
                $ARG, {
                    default => sub {
                        $error->err_msg($ARG, "JSON to Perl conversion error");
                        throw($ARG);
                    }
                }
            );
        };

        try {
            unless ($schema_type eq $struct->{'schemaType'}) {
                throw "Invalid schema type", {
                    'trace' => 3,
                    'type'  => $app_error->err_string(150)->{'symbol'},
                    'code'  => 150,
                    'msg'   => $app_error->err_string(150)->{'string'}
                }
            }
        } catch {
            chomp $ARG;
            classify(
                $ARG, {
                    default => sub {
                        $error->err_msg($ARG, "Invalid file type");
                        throw($ARG);
                    }
                }
            )
        };

        return $struct;
    }

    my sub get_url ($struct) {
        return $struct->{'uri'};
    }

    my sub get_pkgname ($struct) {
        return $struct->{'pkgname'};
    }

    my sub get_pkgversion ($struct) {
        return $struct->{'pkgversion'};
    }

    my sub get_patches ($struct) {
        return @{$struct->{'patches'}};
    }

    my sub get_config_commands ($struct) {
        return $struct->{'configCmds'};
    }

    my sub get_build_commands ($struct) {
        return $struct->{'buildCmds'};
    }

    my sub get_install_commands ($struct) {
        return $struct->{'installCmds'};
    }

    my sub get_source_dir ($struct) {
        return $struct->{'srcTree'};
    }

    my sub get_tools_dir ($struct) {
        return $struct->{'baseToolsDirectory'};
    }

    my sub get_cross_tools_dir ($struct) {
        return $struct->{'crossToolsDirectory'};
    }

    my sub show_help {
        say "build.pl - Perl-based software installer";
        say "-" x 80;
        say "\nOPTIONS:";
        say "=" x 8;
        say "  -c|--config=s  Location of config.json. Normally, this is determined";
        say "                 automatically\n";
        say "  -p|--pkg=s     Which package to build and install. This flag is required\n";
        say "  -s|--stage=s   Which stage this is building. The stage can be one of the";
        say "                 following:";
        say "                  - crosstools";
        say "                  - basetools";
        say "                  - standard";
        say "                 This flag is required.\n";
        say "     --color     Display output in color\n";
        say "  -h|--help      Show this help message\n";
        say "  -v|--version   Show the version of this tool\n";
    }

    my sub show_version {
        say "build.pl - Perl-based software installer";
        say "-" x 80;
        say "Version: $VERSION";
        say "Author: Gary L. Greene, Jr <greeneg at tolharadys dot net>";
        say "License: Apache Public License, version 2.0";
    }

    my sub process_args {
        if (! defined $config_json) {
            # discover the config.json. If not found, throw an exception
        }

        if (! defined $pkg) {
            # this is fatal, we MUST have a package to work
            say "Missing required flag, --pkg\n";
            show_help();
            exit 255;
        }

        if (! defined $stage) {
            # this is fatal, we MUST have a stage to work
            say "Missing required flag, --stage\n";
            show_help();
            exit 255;
        }
    }

    my sub main {
        # define our globals
        my $file_name     = undef;

        my $config_struct = undef;
        if (defined $config_json) {
            $config_struct = read_json(
                $config_json,
                {
                    'type' => 'configuration',
                    'version' => 1
                }
            );            
        } else {
            $config_struct = read_json(
                "$FindBin::Bin/../config/config.json",
                {
                    'type' => 'configuration',
                    'version' => 1
                }
            );
        }
        my $source_dir      = get_source_dir($config_struct);
        my $base_tools_dir  = get_tools_dir($config_struct);
        my $cross_tools_dir = get_cross_tools_dir($config_struct);

        my $stage_dir = undef;
        given ($stage) {
            when ('crosstools') {
                $stage_dir = "crosscompile-tools-pkgs";
            }
            when ('basetools') {
                $stage_dir = "basetools-pkgs";
            }
            when ('standard') {
                $stage_dir = "standard";
            }
        }

        my $pkg_struct   = read_json(
            "$FindBin::Bin/../${stage_dir}/${pkg}/build.json",
            {
                'type' => 'package',
                'version' => 1
            }
        );
        my $uri          = get_url($pkg_struct);
        my $pkg_name     = get_pkgname($pkg_struct);
        my $pkg_version  = get_pkgversion($pkg_struct);
        my @patches      = get_patches($pkg_struct);
        my $config_cmds  = get_config_commands($pkg_struct);
        my $build_cmds   = get_build_commands($pkg_struct);
        my $install_cmds = get_install_commands($pkg_struct);

        my $target_dir = "$FindBin::Bin/../$stage_dir";

    #    pushd 
    }

    GetOptions(
        '--color'       => sub { $color_output = true },
        '-c|--config=s' => \$config_json,
        '-p|--pkg=s'    => \$pkg,
        '-s|--stage=s'  => \$stage,
        '-h|--help'     => sub { show_help() },
        '-v|--version'  => sub { show_version() }
    );
    process_args();
    main();
}