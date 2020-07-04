package File::IO::JSON {
    use strictures;
    use utf8;
    use English;

    use feature ":5.26";
    no warnings "experimental::signatures";
    no warnings "experimental::smartmatch";
    use feature "lexical_subs";
    use feature "signatures";

    use boolean;
    use JSON5;
    use Throw qw(throw classify);
    use Try::Tiny qw(try catch);

    use FindBin;
    use lib "$FindBin::Bin/../lib";

    use AltimatOS::Application::Error;
    use File::IO;
    use Sys::Error;

    my $app_error = undef;
    my $error     = undef;

    sub new ($class) {
        my $self = {};

        $app_error = AltimatOS::Application::Error->new();
        $error = Sys::Error->new();

        bless($self, $class);
        return $self;
    }

    our sub read_json ($self, $path, $params) {
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

    true;
}