package Sys::Error {
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

    our sub err_msg ($self, $err_struct) {
        my $code   = $self->error_code($err_struct->{'type'})->{'code'};
        my $string = $self->error_code($err_struct->{'type'})->{'string'};
        my $symbol = $self->error_code($err_struct->{'type'})->{'symbol'};

        say "$err_struct->{'error'}: $err_struct->{'info'}: $string";
        say "    Info:  $err_struct->{'info'}";
        say "    Trace: $err_struct->{'trace'}";
        say "    Error: code = $code, symbol = $symbol: $string";

        exit $code;
    }

    our sub error_code ($self, $symbol) {
        my $code   = undef;
        my $string = undef;

        given ($symbol) {
            when ('OK') {
                # this is a psuedo error and isn't in POSIX per se
                $code   = 0;
                $string = "Successful operation";
            }
            when ('EPERM') {
                $code   = 1;
                $string = "Permission denied";
            }
            when ('ENOENT') {
                $code   = 2;
                $string = "No such file or directory";
            }
            when ('ESRCH') {
                $code   = 3;
                $string = "No such process";
            }
            when ('EINTR') {
                $code   = 4;
                $string = "Interrupted system call";
            }
            when ('EIO') {
                $code   = 5;
                $string = "Input/output error";
            }
            when ('ENXIO') {
                $code   = 6;
                $string = "No such device or address"
            }
            when ('E2BIG') {
                $code   = 7;
                $string = "Argument list too long";
            }
            when ('ENOEXEC') {
                $code   = 8;
                $string = "Exec format error";
            }
            when ('EBADF') {
                $code   = 9;
                $string = "Bad file descriptor";
            }
            when ('ECHILD') {
                $code   = 10;
                $string = "No child processes"
            }
            when ('EAGAIN') {
                $code   = 11;
                $string = "Resource temporarily unavailable";
            }
            when ('ENOMEM') {
                $code   = 12;
                $string = "Cannot allocate memory";
            }
            when ('EACCESS') {
                $code   = 13;
                $string = "Permission denied";
            }
            when ('EFAULT') {
                $code   = 14;
                $string = "Bad address";
            }
            when ('ENOTBLK') {
                $code   = 15;
                $string = "Block device required";
            }
            when ('EBUSY') {
                $code   = 16;
                $string = "Device or resource busy";
            }
            when ('EEXIST') {
                $code   = 17;
                $string = "File exists";
            }
            when ('EXDEV') {
                $code   = 18;
                $string = "Invalid cross-device link";
            }
            when ('ENODEV') {
                $code   = 19;
                $string = "No such device";
            }
            when ('ENOTDIR') {
                $code   = 20;
                $string = "Not a directory";
            }
            when ('EISDIR') {
                $code   = 21;
                $string = "Is a directory";
            }
            when ('EINVAL') {
                $code   = 22;
                $string = "Invalid argument";
            }
            when ('ENFILE') {
                $code   = 23;
                $string = "Too many open files in system";
            }
            when ('EMFILE') {
                $code   = 24;
                $string = "Too many open files";
            }
            when ('ENOTTY') {
                $code   = 25;
                $string = "Inappropriate ioctl for device";
            }
            when ('ETXTBSY') {
                $code   = 26;
                $string = "Text file busy";
            }
            when ('EFBIG') {
                $code   = 27;
                $string = "File too large";
            }
            when ('ENOSPC') {
                $code   = 28;
                $string = "No space left on device";
            }
            when ('ESPIPE') {
                $code   = 29;
                $string = "Illegal seek";
            }
            when ('EROFS') {
                $code   = 30;
                $string = "Read-only file system";
            }
            when ('EMLINK') {
                $code   = 31;
                $string = "Too many links";
            }
            when ('EPIPE') {
                $code   = 32;
                $string = "Broken pipe";
            }
            when ('EDOM') {
                $code   = 33;
                $string = "Numerical argument out of domain";
            }
            when ('ERANGE') {
                $code   = 34;
                $string = "Numerical result out of range";
            }
            when ('EDEADLK') {
                $code   = 35;
                $string = "Resource deadlock avoided";
            }
            when ('ENAMETOOLONG') {
                $code   = 36;
                $string = "File name too long";
            }
            when ('ENOLCK') {
                $code   = 37;
                $string = "No locks available";
            }
            when ('ENOSYS') {
                $code   = 38;
                $string = "Function not implemented";
            }
            when ('ENOTEMPTY') {
                $code   = 39;
                $string = "Directory not empty";
            }
            when ('ELOOP') {
                $code   = 40;
                $string = "Too many levels of symbolic links";
            }
            when ('ENOMSG') {
                $code   = 42;
                $string = "No message of desired type";
            }
            when ('EIDRM') {
                $code   = 43;
                $string = "Identifier removed";
            }
            when ('ECHRNG') {
                $code   = 44;
                $string = "Channel number out of range";
            }
            when ('EL2NSYNC') {
                $code   = 45;
                $string = "Level 2 not synchronized";
            }
            when ('EL3HLT') {
                $code   = 46;
                $string = "Level 3 halted";
            }
            when ('EL3RST') {
                $code   = 47;
                $string = "Level 3 reset";
            }
            when ('ELNRNG') {
                $code   = 48;
                $string = "Link number out of range";
            }
            when ('EUNATCH') {
                $code   = 49;
                $string = "Protocol driver not attached";
            }
            when ('ENOCSI') {
                $code   = 50;
                $string = "No CSI structure available";
            }
            when ('EL2HLT') {
                $code   = 51;
                $string = "Level 2 halted";
            }
            when ('EBADE') {
                $code   = 52;
                $string = "Invalid exchange";
            }
            when ('EBADR') {
                $code   = 53;
                $string = "Invalid request descriptor";
            }
            when ('EXFULL') {
                $code   = 54;
                $string = "Exchange full";
            }
            when ('ENOANO') {
                $code   = 55;
                $string = "No anode";
            }
            when ('EBADRQC') {
                $code   = 56;
                $string = "Invalid request code";
            }
            when ('EBADSLT') {
                $code   = 57;
                $string = "Invalid slot";
            }
            when ('EBFONT') {
                $code   = 59;
                $string = "Bad font file format";
            }
            when ('ENOSTR') {
                $code   = 60;
                $string = "Device not a stream";
            }
            when ('ENODATA') {
                $code   = 61;
                $string = "No data available";
            }
            when ('ETIME') {
                $code   = 62;
                $string = "Timer expired";
            }
            when ('ENOSR') {
                $code   = 63;
                $string = "Out of streams resources";
            }
            when ('ENONET') {
                $code   = 64;
                $string = "Machine is not on the network";
            }
            when ('ENOPKG') {
                $code   = 65;
                $string = "Package not installed";
            }
            when ('EREMOTE') {
                $code   = 66;
                $string = "Object is remote";
            }
            when ('ENOLINK') {
                $code   = 67;
                $string = "Link has been severed";
            }
            when ('EADV') {
                $code   = 68;
                $string = "Advertise error";
            }
            when ('ESRMNT') {
                $code   = 69;
                $string = "Srmount error";
            }
            when ('ECOMM') {
                $code   = 70;
                $string = "Communication error on send";
            }
            when ('EPROTO') {
                $code   = 71;
                $string = "Protocol error";
            }
            when ('EMULTIHOP') {
                $code   = 72;
                $string = "Multihop attempted";
            }
            when ('EDOTDOT') {
                $code   = 73;
                $string = "RFS specific error";
            }
            when ('EBADMSG') {
                $code   = 74;
                $string = "Bad message";
            }
            when ('EOVERFLOW') {
                $code   = 75;
                $string = "Value too large for defined data type";
            }
            when ('ENOTUNIQ') {
                $code   = 76;
                $string = "Name not unique on network";
            }
            when ('EBADFD') {
                $code   = 77;
                $string = "File descriptor in bad state";
            }
            when ('EREMCHG') {
                $code   = 78;
                $string = "Remote address changed";
            }
            when ('ELIBACC') {
                $code   = 79;
                $string = "Can not access a needed shared library";
            }
            when ('ELIBBAD') {
                $code   = 80;
                $string = "Accessing a corrupted shared library";
            }
            when ('ELIBSCN') {
                $code   = 81;
                $string = ".lib section in a.out corrupted";
            }
            when ('ELIBMAX') {
                $code   = 82;
                $string = "Attempting to link in too many shared libraries";
            }
            when ('ELIBEXEC') {
                $code   = 83;
                $string = "Cannot exec a shared library directly";
            }
            when ('EILSEQ') {
                $code   = 84;
                $string = "Invalid or incomplete multibyte or wide character";
            }
            when ('ERESTART') {
                $code   = 85;
                $string = "Interrupted system call should be restarted";
            }
            when ('ESTRPIPE') {
                $code   = 86;
                $string = "Streams pipe error";
            }
            when ('EUSERS') {
                $code   = 87;
                $string = "Too many users";
            }
            when ('ENOTSOCK') {
                $code   = 88;
                $string = "Socket operation on non-socket";
            }
            when ('EDESTADDRREQ') {
                $code   = 89;
                $string = "Destination address required";
            }
            when ('EMSGSIZE') {
                $code   = 90;
                $string = "Message too long";
            }
            when ('EPROTOTYPE') {
                $code   = 91;
                $string = "Protocol wrong type for socket";
            }
            when ('ENOPROTOOPT') {
                $code   = 92;
                $string = "Protocol not available";
            }
            when ('EPROTONOSUPPORT') {
                $code   = 93;
                $string = "Protocol not supported";
            }
            when ('ESOCKTNOSUPPORT') {
                $code   = 94;
                $string = "Socket type not supported";
            }
            when ('EOPNOTSUPP') {
                $code   = 95;
                $string = "Operation not supported";
            }
            when ('EPFNOSUPPORT') {
                $code   = 96;
                $string = "Protocol family not supported";
            }
            when ('EAFNOSUPPORT') {
                $code   = 97;
                $string = "Address family not supported by protocol";
            }
            when ('EADDRINUSE') {
                $code   = 98;
                $string = "Address already in use";
            }
            when ('EADDRNOTAVAIL') {
                $code   = 99;
                $string = "Cannot assign requested address";
            }
            when ('ENETDOWN') {
                $code   = 100;
                $string = "Network is down";
            }
            when ('ENETUNREACH') {
                $code   = 101;
                $string = "Network is unreachable";
            }
            when ('ENETRESET') {
                $code   = 102;
                $string = "Network dropped connection on reset";
            }
            when ('ECONNABORTED') {
                $code   = 103;
                $string = "Software caused connection abort";
            }
            when ('ECONNRESET') {
                $code   = 104;
                $string = "Connection reset by peer";
            }
            when ('ENOBUFS') {
                $code   = 105;
                $string = "No buffer space available";
            }
            when ('EISCONN') {
                $code   = 106;
                $string = "Transport endpoint is already connected";
            }
            when ('ENOTCONN') {
                $code   = 107;
                $string = "Transport endpoint is not connected";
            }
            when ('ESHUTDOWN') {
                $code   = 108;
                $string = "Cannot send after transport endpoint shutdown";
            }
            when ('ETOOMANYREFS') {
                $code   = 109;
                $string = "Too many references: cannot splice";
            }
            when ('ETIMEDOUT') {
                $code   = 110;
                $string = "Connection timed out";
            }
            when ('ECONNREFUSED') {
                $code   = 111;
                $string = "Connection refused";
            }
            when ('EHOSTDOWN') {
                $code   = 112;
                $string = "Host is down";
            }
            when ('EHOSTUNREACH') {
                $code   = 113;
                $string = "No route to host";
            }
            when ('EALREADY') {
                $code   = 114;
                $string = "Operation already in progress";
            }
            when ('EINPROGRESS') {
                $code   = 115;
                $string = "Operation now in progress";
            }
            when ('ESTALE') {
                $code   = 116;
                $string = "Stale file handle";
            }
            when ('EUCLEAN') {
                $code   = 117;
                $string = "Structure needs cleaning";
            }
            when ('ENOTNAM') {
                $code   = 118;
                $string = "Not a XENIX named type file";
            }
            when ('ENAVAIL') {
                $code   = 119;
                $string = "No XENIX semaphores available";
            }
            when ('EISNAM') {
                $code   = 120;
                $string = "Is a named type file";
            }
            when ('EREMOTEIO') {
                $code   = 121;
                $string = "Remote I/O error";
            }
            when ('EDQUOT') {
                $code   = 122;
                $string = "Disk quota exceeded";
            }
            when ('ENOMEDIUM') {
                $code   = 123;
                $string = "No medium found";
            }
            when ('EMEDIUMTYPE') {
                $code   = 124;
                $string = "Wrong medium type";
            }
            when ('ECANCELED') {
                $code   = 125;
                $string = "Operation canceled";
            }
            when ('ENOKEY') {
                $code   = 126;
                $string = "Required key not available";
            }
            when ('EKEYEXPIRED') {
                $code   = 127;
                $string = "Key has expired";
            }
            when ('EKEYREVOKED') {
                $code   = 128;
                $string = "Key has been revoked";
            }
            when ('EKEYREJECTED') {
                $code   = 129;
                $string = "Key was rejected by service";
            }
            when ('EOWNERDEAD') {
                $code   = 130;
                $string = "Owner died";
            }
            when ('ENOTRECOVERABLE') {
                $code   = 131;
                $string = "State not recoverable";
            }
            when ('ERFKILL') {
                $code   = 132;
                $string = "Operation not possible due to RF-kill";
            }
            when ('EHWPOISON') {
                $code   = 133;
                $string = "Memory page has hardware error";
            }
        }

        return {
            'code'   => $code,
            'string' => $string,
            'symbol' => $symbol
        }
    }

    our sub error_string ($self, $code) {
        my $symbol = undef;
        my $string = undef;
        given ($code) {
            when (0) {
                # this is a psuedo error and isn't in POSIX per se
                $symbol = "OK";
                $string = "Successful operation";
            }
            when (1) {
                $symbol = "EPERM";
                $string = "Permission denied";
            }
            when (2) {
                $symbol = "ENOENT";
                $string = "No such file or directory";
            }
            when (3) {
                $symbol = "ESRCH";
                $string = "No such process";
            }
            when (4) {
                $symbol = "EINTR";
                $string = "Interrupted system call";
            }
            when (5) {
                $symbol = "EIO";
                $string = "Input/output error";
            }
            when (6) {
                $symbol = "ENXIO";
                $string = "No such device or address"
            }
            when (7) {
                $symbol = "E2BIG";
                $string = "Argument list too long";
            }
            when (8) {
                $symbol = "ENOEXEC";
                $string = "Exec format error";
            }
            when (9) {
                $symbol = "EBADF";
                $string = "Bad file descriptor";
            }
            when (10) {
                $symbol = "ECHILD";
                $string = "No child processes"
            }
            when (11) {
                $symbol = "EAGAIN";
                $string = "Resource temporarily unavailable";
            }
            when (12) {
                $symbol = "ENOMEM";
                $string = "Cannot allocate memory";
            }
            when (13) {
                $symbol = "EACCES";
                $string = "Permission denied";
            }
            when (14) {
                $symbol = "EFAULT";
                $string = "Bad address";
            }
            when (15) {
                $symbol = "ENOTBLK";
                $string = "Block device required";
            }
            when (16) {
                $symbol = "EBUSY";
                $string = "Device or resource busy";
            }
            when (17) {
                $symbol = "EEXIST";
                $string = "File exists";
            }
            when (18) {
                $symbol = "EXDEV";
                $string = "Invalid cross-device link";
            }
            when (19) {
                $symbol = "ENODEV";
                $string = "No such device";
            }
            when (20) {
                $symbol = "ENOTDIR";
                $string = "Not a directory";
            }
            when (21) {
                $symbol = "EISDIR";
                $string = "Is a directory";
            }
            when (22) {
                $symbol = "EINVAL";
                $string = "Invalid argument";
            }
            when (23) {
                $symbol = "ENFILE";
                $string = "Too many open files in system";
            }
            when (24) {
                $symbol = "EMFILE";
                $string = "Too many open files";
            }
            when (25) {
                $symbol = "ENOTTY";
                $string = "Inappropriate ioctl for device";
            }
            when (26) {
                $symbol = "ETXTBSY";
                $string = "Text file busy";
            }
            when (27) {
                $symbol = "EFBIG";
                $string = "File too large";
            }
            when (28) {
                $symbol = "ENOSPC";
                $string = "No space left on device";
            }
            when (29) {
                $symbol = "ESPIPE";
                $string = "Illegal seek";
            }
            when (30) {
                $symbol = "EROFS";
                $string = "Read-only file system";
            }
            when (31) {
                $symbol = "EMLINK";
                $string = "Too many links";
            }
            when (32) {
                $symbol = "EPIPE";
                $string = "Broken pipe";
            }
            when (33) {
                $symbol = "EDOM";
                $string = "Numerical argument out of domain";
            }
            when (34) {
                $symbol = "ERANGE";
                $string = "Numerical result out of range";
            }
            when (35) {
                $symbol = "EDEADLK";
                $string = "Resource deadlock avoided";
            }
            when (36) {
                $symbol = "ENAMETOOLONG";
                $string = "File name too long";
            }
            when (37) {
                $symbol = "ENOLCK";
                $string = "No locks available";
            }
            when (38) {
                $symbol = "ENOSYS";
                $string = "Function not implemented";
            }
            when (39) {
                $symbol = "ENOTEMPTY";
                $string = "Directory not empty";
            }
            when (40) {
                $symbol = "ELOOP";
                $string = "Too many levels of symbolic links";
            }
            when (42) {
                $symbol = "ENOMSG";
                $string = "No message of desired type";
            }
            when (43) {
                $symbol = "EIDRM";
                $string = "Identifier removed";
            }
            when (44) {
                $symbol = "ECHRNG";
                $string = "Channel number out of range";
            }
            when (45) {
                $symbol = "EL2NSYNC";
                $string = "Level 2 not synchronized";
            }
            when (46) {
                $symbol = "EL3HLT";
                $string = "Level 3 halted";
            }
            when (47) {
                $symbol = "EL3RST";
                $string = "Level 3 reset";
            }
            when (48) {
                $symbol = "ELNRNG";
                $string = "Link number out of range";
            }
            when (49) {
                $symbol = "EUNATCH";
                $string = "Protocol driver not attached";
            }
            when (50) {
                $symbol = "ENOCSI";
                $string = "No CSI structure available";
            }
            when (51) {
                $symbol = "EL2HLT";
                $string = "Level 2 halted";
            }
            when (52) {
                $symbol = "EBADE";
                $string = "Invalid exchange";
            }
            when (53) {
                $symbol = "EBADR";
                $string = "Invalid request descriptor";
            }
            when (54) {
                $symbol = "EXFULL";
                $string = "Exchange full";
            }
            when (55) {
                $symbol = "ENOANO";
                $string = "No anode";
            }
            when (56) {
                $symbol = "EBADRQC";
                $string = "Invalid request code";
            }
            when (57) {
                $symbol = "EBADSLT";
                $string = "Invalid slot";
            }
            when (59) {
                $symbol = "EBFONT";
                $string = "Bad font file format";
            }
            when (60) {
                $symbol = "ENOSTR";
                $string = "Device not a stream";
            }
            when (61) {
                $symbol = "ENODATA";
                $string = "No data available";
            }
            when (62) {
                $symbol = "ETIME";
                $string = "Timer expired";
            }
            when (63) {
                $symbol = "ENOSR";
                $string = "Out of streams resources";
            }
            when (64) {
                $symbol = "ENONET";
                $string = "Machine is not on the network";
            }
            when (65) {
                $symbol = "ENOPKG";
                $string = "Package not installed";
            }
            when (66) {
                $symbol = "EREMOTE";
                $string = "Object is remote";
            }
            when (67) {
                $symbol = "ENOLINK";
                $string = "Link has been severed";
            }
            when (68) {
                $symbol = "EADV";
                $string = "Advertise error";
            }
            when (69) {
                $symbol = "ESRMNT";
                $string = "Srmount error";
            }
            when (70) {
                $symbol = "ECOMM";
                $string = "Communication error on send";
            }
            when (71) {
                $symbol = "EPROTO";
                $string = "Protocol error";
            }
            when (72) {
                $symbol = "EMULTIHOP";
                $string = "Multihop attempted";
            }
            when (73) {
                $symbol = "EDOTDOT";
                $string = "RFS specific error";
            }
            when (74) {
                $symbol = "EBADMSG";
                $string = "Bad message";
            }
            when (75) {
                $symbol = "EOVERFLOW";
                $string = "Value too large for defined data type";
            }
            when (76) {
                $symbol = "ENOTUNIQ";
                $string = "Name not unique on network";
            }
            when (77) {
                $symbol = "EBADFD";
                $string = "File descriptor in bad state";
            }
            when (78) {
                $symbol = "EREMCHG";
                $string = "Remote address changed";
            }
            when (79) {
                $symbol = "ELIBACC";
                $string = "Can not access a needed shared library";
            }
            when (80) {
                $symbol = "ELIBBAD";
                $string = "Accessing a corrupted shared library";
            }
            when (81) {
                $symbol = "ELIBSCN";
                $string = ".lib section in a.out corrupted";
            }
            when (82) {
                $symbol = "ELIBMAX";
                $string = "Attempting to link in too many shared libraries";
            }
            when (83) {
                $symbol = "ELIBEXEC";
                $string = "Cannot exec a shared library directly";
            }
            when (84) {
                $symbol = "EILSEQ";
                $string = "Invalid or incomplete multibyte or wide character";
            }
            when (85) {
                $symbol = "ERESTART";
                $string = "Interrupted system call should be restarted";
            }
            when (86) {
                $symbol = "ESTRPIPE";
                $string = "Streams pipe error";
            }
            when (87) {
                $symbol = "EUSERS";
                $string = "Too many users";
            }
            when (88) {
                $symbol = "ENOTSOCK";
                $string = "Socket operation on non-socket";
            }
            when (89) {
                $symbol = "EDESTADDRREQ";
                $string = "Destination address required";
            }
            when (90) {
                $symbol = "EMSGSIZE";
                $string = "Message too long";
            }
            when (91) {
                $symbol = "EPROTOTYPE";
                $string = "Protocol wrong type for socket";
            }
            when (92) {
                $symbol = "ENOPROTOOPT";
                $string = "Protocol not available";
            }
            when (93) {
                $symbol = "EPROTONOSUPPORT";
                $string = "Protocol not supported";
            }
            when (94) {
                $symbol = "ESOCKTNOSUPPORT";
                $string = "Socket type not supported";
            }
            when (95) {
                $symbol = "EOPNOTSUPP";
                $string = "Operation not supported";
            }
            when (96) {
                $symbol = "EPFNOSUPPORT";
                $string = "Protocol family not supported";
            }
            when (97) {
                $symbol = "EAFNOSUPPORT";
                $string = "Address family not supported by protocol";
            }
            when (98) {
                $symbol = "EADDRINUSE";
                $string = "Address already in use";
            }
            when (99) {
                $symbol = "EADDRNOTAVAIL";
                $string = "Cannot assign requested address";
            }
            when (100) {
                $symbol = "ENETDOWN";
                $string = "Network is down";
            }
            when (101) {
                $symbol = "ENETUNREACH";
                $string = "Network is unreachable";
            }
            when (102) {
                $symbol = "ENETRESET";
                $string = "Network dropped connection on reset";
            }
            when (103) {
                $symbol = "ECONNABORTED";
                $string = "Software caused connection abort";
            }
            when (104) {
                $symbol = "ECONNRESET";
                $string = "Connection reset by peer";
            }
            when (105) {
                $symbol = "ENOBUFS";
                $string = "No buffer space available";
            }
            when (106) {
                $symbol = "EISCONN";
                $string = "Transport endpoint is already connected";
            }
            when (107) {
                $symbol = "ENOTCONN";
                $string = "Transport endpoint is not connected";
            }
            when (108) {
                $symbol = "ESHUTDOWN";
                $string = "Cannot send after transport endpoint shutdown";
            }
            when (109) {
                $symbol = "ETOOMANYREFS";
                $string = "Too many references: cannot splice";
            }
            when (110) {
                $symbol = "ETIMEDOUT";
                $string = "Connection timed out";
            }
            when (111) {
                $symbol = "ECONNREFUSED";
                $string = "Connection refused";
            }
            when (112) {
                $symbol = "EHOSTDOWN";
                $string = "Host is down";
            }
            when (113) {
                $symbol = "EHOSTUNREACH";
                $string = "No route to host";
            }
            when (114) {
                $symbol = "EALREADY";
                $string = "Operation already in progress";
            }
            when (115) {
                $symbol = "EINPROGRESS";
                $string = "Operation now in progress";
            }
            when (116) {
                $symbol = "ESTALE";
                $string = "Stale file handle";
            }
            when (117) {
                $symbol = "EUCLEAN";
                $string = "Structure needs cleaning";
            }
            when (118) {
                $symbol = "ENOTNAM";
                $string = "Not a XENIX named type file";
            }
            when (119) {
                $symbol = "ENAVAIL";
                $string = "No XENIX semaphores available";
            }
            when (120) {
                $symbol = "EISNAM";
                $string = "Is a named type file";
            }
            when (121) {
                $symbol = "EREMOTEIO";
                $string = "Remote I/O error";
            }
            when (122) {
                $symbol = "EDQUOT";
                $string = "Disk quota exceeded";
            }
            when (123) {
                $symbol = "ENOMEDIUM";
                $string = "No medium found";
            }
            when (124) {
                $symbol = "EMEDIUMTYPE";
                $string = "Wrong medium type";
            }
            when (125) {
                $symbol = "ECANCELED";
                $string = "Operation canceled";
            }
            when (126) {
                $symbol = "ENOKEY";
                $string = "Required key not available";
            }
            when (127) {
                $symbol = "EKEYEXPIRED";
                $string = "Key has expired";
            }
            when (128) {
                $symbol = "EKEYREVOKED";
                $string = "Key has been revoked";
            }
            when (129) {
                $symbol = "EKEYREJECTED";
                $string = "Key was rejected by service";
            }
            when (130) {
                $symbol = "EOWNERDEAD";
                $string = "Owner died";
            }
            when (131) {
                $symbol = "ENOTRECOVERABLE";
                $string = "State not recoverable";
            }
            when (132) {
                $symbol = "ERFKILL";
                $string = "Operation not possible due to RF-kill";
            }
            when (133) {
                $symbol = "EHWPOISON";
                $string = "Memory page has hardware error";
            }
        }

        return {
            'code'   => $code,
            'string' => $string,
            'symbol' => $symbol
        }
    }

    true;
}