package Console::IO {
    use strictures;
    use utf8;
    use English;

    use feature ":5.26";
    no warnings "experimental::signatures";
    no warnings "experimental::smartmatch";
    use feature "lexical_subs";
    use feature "signatures";

    use Exporter 'import';

    our @EXPORT_OK = qw(
        cout
    );

    use boolean;
    use Term::ANSIColor;

    our sub cout ($string, $newline = true, $color_output = false, $color_attrib = '', $do_reset = false) {
        my $output = undef;
        if ($color_output eq true && defined $color_attrib) {
            if (defined $do_reset && $do_reset eq true) {
                $output = color($color_attrib) . $string . color('reset');
            } else {
                $output = color($color_attrib) . $string;
            }
        } else {
            $output = $string;
        }

        if (defined $newline && $newline eq true) {
            say $output;
        } else {
            print $output;
        }
    }

    true;
}