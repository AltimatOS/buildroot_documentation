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

package main v1.0.0 {
    use strictures;
    use utf8;
    use English;

    use feature ":5.26";
    no warnings "experimental::signatures";
    no warnings "experimental::smartmatch";
    use feature "lexical_subs";
    use feature "signatures";

    use FindBin;
    use lib "$FindBin::Bin/../lib";

    use Archive::Tar;
    use boolean qw(:all);
    use Cwd;
    use File::Copy 'cp';
    use File::LibMagic;
    use File::Tools qw(:all);
    use Getopt::Long qw(:config gnu_compat);
    use LWP::UserAgent;

    use Console::IO qw(cout);
    use File::IO;
    use File::IO::JSON;
    use GNUzip::Decompress;
    use Sys::Error;

    use AltimatOS::Build;
    use AltimatOS::Application::Error;

    # global settings
    $Throw::pretty = 1;
    $Throw::trace  = 1;

    # some globals
    my $color_output = false;

    my $app_error    = AltimatOS::Application::Error->new();
    my $error        = Sys::Error->new();

    my sub main (@args) {
        my %flags = (
            'debug'     => false,
            'loglevel'  => 'none',
            'logger'    => 'syslog'
        );

        GetOptions(
            'color'      => sub { $color_output = true },
            'c|config=s' => sub { $flags{'config_json'} = $ARG[1] },
            'p|pkg=s'    => sub { $flags{'pkg'}         = ucfirst($ARG[1]) },
            's|stage=s'  => sub { $flags{'stage'}       = $ARG[1] },
            'h|help'     => sub { AltimatOS::Build::show_help(); exit 0; },
            'v|version'  => sub { AltimatOS::Build::show_version(); exit 0; }
        );
        my $builder = AltimatOS::Build->new(\%flags);
        my $json_io = File::IO::JSON->new();

        $builder->process_args(\%flags);

        my $config_struct = undef;
        if (defined $flags{'config_json'}) {
            $config_struct = $json_io->read_json(
                $flags{'config_json'},
                {
                    'type'    => 'configuration',
                    'version' => 1
                }
            );            
        } else {
            $config_struct = $json_io->read_json(
                "$FindBin::Bin/../config/config.json",
                {
                    'type'    => 'configuration',
                    'version' => 1
                }
            );
        }
        my $source_dir      = $builder->get_source_dir($config_struct);
        my $base_tools_dir  = $builder->get_tools_dir($config_struct);
        my $cross_tools_dir = $builder->get_cross_tools_dir($config_struct);

        my $stage_dir = undef;
        given ($flags{'stage'}) {
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

        my $pkg_struct   = $json_io->read_json(
            "$FindBin::Bin/../${stage_dir}/$flags{'pkg'}/build.json",
            {
                'type'    => 'package',
                'version' => 1
            }
        );
        my $uri          = $builder->get_url($pkg_struct);
        my $pkg_name     = $builder->get_pkgname($pkg_struct);
        my $pkg_version  = $builder->get_pkgversion($pkg_struct);
        my $file_name    = $builder->get_file_name($pkg_struct, $pkg_version);
        my @patches      = $builder->get_patches($pkg_struct);
        my $config_cmds  = $builder->get_config_commands($pkg_struct);
        my $build_cmds   = $builder->get_build_commands($pkg_struct);
        my $install_cmds = $builder->get_install_commands($pkg_struct);

        my $target_dir = "$FindBin::Bin/../$stage_dir";

        # display what is to be built:
        cout("Starting Build Tool...", true, $color_output, 'bold white', true);
        cout("Build Stage: $flags{'stage'}", true, $color_output, 'bold cyan', true);
        cout("Package Name: $pkg_name", true, $color_output, 'bold cyan', true);
        cout("Package Version: $pkg_version", true, $color_output, 'bold cyan', true);

        pushd $source_dir;
            my $wd = getcwd();
            cout("Working Directory: $wd", true, $color_output, 'magenta', true);
            cout("Package URL: $uri/$file_name", true, $color_output, 'bold cyan', true);

            # get package from remote site
            # using curl directly for now. Will move to using LWP soon
            cout("\nDownloading $file_name:", true, $color_output, 'bold blue', false);
            system('curl', '-L', '-#', '--url', "${uri}/${file_name}", '--output', ${file_name});
            cout("", false, $color_output, 'bold blue', true);

            # determine type of archive that was downloaded
            cout("Determining archive type... ", false, $color_output, 'bold cyan', false);
            my $magic = File::LibMagic->new();
            my $info  = $magic->info_from_filename("$source_dir/$file_name");
            my $mime  = $info->{'mime_type'};
            cout($mime, true, $color_output, 'bold yellow', true);

            # unpack file
            given ($mime) {
                when ('application/gzip') {
                    # this is likely a tarball with gzip compression, so first uncompress archive
                    
                }
            }

            # enter package source directory

            # if there are patches, patch it

            # configure the sources

            # build them

            # install them
        popd
    }

    main(@ARGV);
}