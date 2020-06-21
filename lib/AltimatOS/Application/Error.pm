package AltimatOS::Application::Error {
    use strict;
    use warnings;
    use utf8;
    use English;

    use feature ":5.26";
    no warnings "experimental::signatures";
    no warnings "experimental::smartmatch";
    use feature "lexical_subs";
    use feature "signatures";
    use feature "switch";

    use boolean;

    sub new ($class) {
        my $self = {};

        bless($self, $class);
        return $self;
    }

    our sub error_string ($self, $error_code) {
        my $symbol     = undef;
        my $err_string = undef;
        given ($error_code) {
            when (150) {
                $symbol     = 'EINVFILETYPE',
                $err_string = 'Invalid requested file type'
            }
        }

        return {
            'code'      => $error_code,
            'string'    => $err_string,
            'symbol'    => $symbol
        }

    }

    true;
}