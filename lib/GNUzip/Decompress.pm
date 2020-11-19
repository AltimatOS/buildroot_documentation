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
        cout "File name: $file";
        my ($fn, $extension) = split(/\..*$/, $file);
        return $extension;
    }

    our sub decompress ($self, $file) {
        # get the extension of the file
        cout "File name: $file";
        my $extension = get_extension($file);

        cout "File extension: $extension";

        # my $uncompressed_file = 
        # we expect that they sent us a gzipped file

    }

    true;
}