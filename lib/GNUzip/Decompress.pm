package GNUzip::Decompress {
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
    use File::Basename;
    use IO::Uncompress::Gunzip qw(gunzip $GunzipError);
    use Throw qw(throw classify);
    use Try::Tiny qw(try catch);

    use FindBin;
    use lib "$FindBin::Bin/../lib";

    use Console::IO qw(cout);
    use Sys::Error;

    $Throw::level = 1;
    my $error = undef;

    sub new ($class) {
        my $self = {};

        $error = Sys::Error->new();

        bless($self, $class);

        return $self;
    }

    my sub get_extension ($file) {
        # split the file into it's filename parts
        my ($fn, $extension) = basename($file) =~ m/^(.*)\.([a-zA-Z0-9]+)$/;
        return $fn, $extension;
    }

    our sub decompress ($self, $file) {
        # get the extension of the file
        cout "File name: $file";
        my ($ucfilename, $extension) = get_extension($file);

        cout "File extension: $extension";
        cout "Un-compressed filename: $ucfilename";

        # we expect that they sent us a gzipped file
        try {
            gunzip $file => $ucfilename or
              throw "GNUzip Decompression error", {
                  'trace' => 3,
                  'info'  => "Attempted to decompress '$file'",
                  'error' => "$GunzipError",
                  'msg'   => "$GunzipError"
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
    }

    true;
}