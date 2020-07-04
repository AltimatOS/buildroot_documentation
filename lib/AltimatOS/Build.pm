package AltimatOS::Build v1.0.0 {
    use strictures;
    use utf8;
    use English;

    use feature ":5.26";
    no warnings "experimental::signatures";
    no warnings "experimental::smartmatch";
    use feature "lexical_subs";
    use feature "signatures";

    use boolean;

    my $debug  = undef;
    my $logger = undef;
    my $loglvl = undef;

    sub new ($class, $flags) {
        my $self = {};

        $debug  = $flags->{'debug'};
        $logger = $flags->{'logger'};
        $loglvl = $flags->{'loglevel'};

        bless($self, $class);
        return $self;
    }

    our sub get_url ($self, $struct) {
        return $struct->{'url'};
    }

    our sub get_pkgname ($self, $struct) {
        return $struct->{'pkgname'};
    }

    our sub get_pkgversion ($self, $struct) {
        return $struct->{'pkgversion'};
    }

    our sub get_file_name ($self, $struct, $pkg_version) {
        my $f = $struct->{'file'};
        # ugly, but the only way to autointerpolate stuff coming in as a static string
        $f =~ s/(\$\{\w+\})/$pkg_version/gee;
        return "$f";
    }

    our sub get_patches ($self, $struct) {
        return @{$struct->{'patches'}};
    }

    our sub get_config_commands ($self, $struct) {
        return $struct->{'configCmds'};
    }

    our sub get_build_commands ($self, $struct) {
        return $struct->{'buildCmds'};
    }

    our sub get_install_commands ($self, $struct) {
        return $struct->{'installCmds'};
    }

    our sub get_source_dir ($self, $struct) {
        return $struct->{'srcTree'};
    }

    our sub get_tools_dir ($self, $struct) {
        return $struct->{'baseToolsDirectory'};
    }

    our sub get_cross_tools_dir ($self, $struct) {
        return $struct->{'crossToolsDirectory'};
    }

    our sub process_args ($self, $flags) {
        if (not defined $flags->{'config_json'}) {
            # discover the config.json. If not found, throw an exception
        }

        if (not defined $flags->{'pkg'}) {
            # this is fatal, we MUST have a package to work
            say "Missing required flag, --pkg\n";
            show_help();
            exit 255;
        }

        if (not defined $flags->{'stage'}) {
            # this is fatal, we MUST have a stage to work
            say "Missing required flag, --stage\n";
            show_help();
            exit 255;
        }
    }

    our sub show_help {
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

    our sub show_version {
        say "build.pl - Perl-based software installer";
        say "=" x 80;
        say "Version: v1.0.0";
        say "Author:  Gary L. Greene, Jr <greeneg at tolharadys dot net>";
        say "License: Apache Public License, version 2.0";
    }

    true;
}