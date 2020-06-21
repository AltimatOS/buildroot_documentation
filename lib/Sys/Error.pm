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

    our sub err_msg ($self, $err_struct, $class) {
        say "$err_struct->{'error'}: $class";
        say "    Info:       $err_struct->{'info'}";
        say "    Trace:      $err_struct->{'trace'}";
        say "    Error code: $err_struct->{'type'}: $err_struct->{'error_string'}";

        exit $err_struct->{type};
    }

    our sub error_string ($self, $error_code) {
        my $symbol     = undef;
        my $err_string = undef;
        given ($error_code) {
            when (0) {
                # this is a psuedo error and isn't in POSIX per se
                $symbol     = "OK";
                $err_string = "Successful operation";
            }
            when (1) {
                $symbol     = "EPERM";
                $err_string = "Permission denied";
            }
            when (2) {
                $symbol     = "ENOENT";
                $err_string = "No such file or directory";
            }
            when (3) {
                $symbol     = "ESRCH";
                $err_string = "No such process";
            }
            when (4) {
                $symbol     = "EINTR";
                $err_string = "Interrupted system call";
            }
            when (5) {
                $symbol     = "EIO";
                $err_string = "Input/output error";
            }
            when (6) {
                $symbol     = "ENXIO";
                $err_string = "No such device or address"
            }
            when (7) {
                $symbol     = "E2BIG";
                $err_string = "Argument list too long";
            }
            when (8) {
                $symbol     = "ENOEXEC";
                $err_string = "Exec format error";
            }
            when (9) {
                $symbol     = "EBADF";
                $err_string = "Bad file descriptor";
            }
            when (10) {
                $symbol     = "ECHILD";
                $err_string = "No child processes"
            }
            when (11) {
                $symbol     = "EAGAIN";
                $err_string = "Resource temporarily unavailable";
            }
            when (12) {
                $symbol     = "ENOMEM";
                $err_string = "Cannot allocate memory";
            }
            when (13) {
                $symbol     = "EACCES";
                $err_string = "Permission denied";
            }
            when (14) {
                $symbol     = "EFAULT";
                $err_string = "Bad address";
            }
            when (15) {
                $symbol     = "ENOTBLK";
                $err_string = "Bock device required";
            }
            when (16) {
                $symbol     = "EBUSY";
                $err_string = "Device or resource busy";
            }
            when (17) {
                $symbol     = "EEXIST";
                $err_string = "Fie exists";
            }
            when (18) {
                $symbol     = "EXDEV";
                $err_string = "Invalid cross-device link";
            }
            when (19) {
                $symbol     = "ENODEV";
                $err_string = "No such device";
            }
            when (20) {
                $symbol     = "ENOTDIR";
                $err_string = "Not a directory";
            }
            when (21) {
                $symbol     = "EISDIR";
                $err_string = "Is a directory";
            }
            when (22) {
                $symbol     = "EINVAL";
                $err_string = "Invalid argument";
            }
            when (23) {
                $symbol     = "ENFILE";
                $err_string = "Too many open files in system";
            }
            when (24) {
                $symbol     = "EMFILE";
                $err_string = "Too many open files";
            }
            when (25) {
                $symbol     = "ENOTTY";
                $err_string = "Inappropriate ioctl for device";
            }
            when (26) {
                $symbol     = "ETXTBSY";
                $err_string = "Text file busy";
            }
            when (27) {
                $symbol     = "EFBIG";
                $err_string = "File too large";
            }
            when (28) {
                $symbol     = "ENOSPC";
                $err_string = "No space left on device";
            }
            when (29) {
                $symbol     = "ESPIPE";
                $err_string = "Illegal seek";
            }
            when (30) {
                $symbol     = "EROFS";
                $err_string = "Read-only file system";
            }
            when (31) {
                $symbol     = "EMLINK";
                $err_string = "Too many links";
            }
            when (32) {
                $symbol     = "EPIPE";
                $err_string = "Broken pipe";
            }
            when (33) {
                $symbol     = "EDOM";
                $err_string = "Numerical argument out of domain";
            }
            when (34) {
                $symbol     = "ERANGE";
                $err_string = "Numerical result out of range";
            }
            when (35) {
                $symbol     = "EDEADLK";
                $err_string = "Resource deadlock avoided";
            }
            when (36) {
                $symbol     = "ENAMETOOLONG";
                $err_string = "File name too long";
            }
            when (37) {
                $symbol     = "ENOLCK";
                $err_string = "No locks available";
            }
            when (38) {
                $symbol     = "ENOSYS";
                $err_string = "Function not implemented";
            }
            when (39) {
                $symbol     = "ENOTEMPTY";
                $err_string = "Directory not empty";
            }
            when (40) {
                $symbol     = "ELOOP";
                $err_string = "Too many levels of symbolic links";
            }
            when (42) {
                $symbol     = "ENOMSG";
                $err_string = "No message of desired type";
            }
            when (43) {
                $symbol     = "EIDRM";
                $err_string = "Identifier removed";
            }
            when (44) {
                $symbol     = "ECHRNG";
                $err_string = "Channel number out of range";
            }
            when (45) {
                $symbol     = "EL2NSYNC";
                $err_string = "Level 2 not synchronized";
            }
            when (46) {
                $symbol     = "EL3HLT";
                $err_string = "Level 3 halted";
            }
            when (47) {
                $symbol     = "EL3RST";
                $err_string = "Level 3 reset";
            }
            when (48) {
                $symbol     = "ELNRNG";
                $err_string = "Link number out of range";
            }
            when (49) {
                $symbol     = "EUNATCH";
                $err_string = "Protocol driver not attached";
            }
            when (50) {
                $symbol     = "ENOCSI";
                $err_string = "No CSI structure available";
            }
            when (51) {
                $symbol     = "EL2HLT";
                $err_string = "Level 2 halted";
            }
            when (52) {
                $symbol     = "EBADE";
                $err_string = "Invalid exchange";
            }
            when (53) {
                $symbol     = "EBADR";
                $err_string = "Invalid request descriptor";
            }
            when (54) {
                $symbol     = "EXFULL";
                $err_string = "Exchange full";
            }
            when (55) {
                $symbol     = "ENOANO";
                $err_string = "No anode";
            }
            when (56) {
                $symbol     = "EBADRQC";
                $err_string = "Invalid request code";
            }
            when (57) {
                $symbol     = "EBADSLT";
                $err_string = "Invalid slot";
            }
            when (59) {
                $symbol     = "EBFONT";
                $err_string = "Bad font file format";
            }
            when (60) {
                $symbol     = "ENOSTR";
                $err_string = "Device not a stream";
            }
            when (61) {
                $symbol     = "ENODATA";
                $err_string = "No data available";
            }
            when (62) {
                $symbol     = "ETIME";
                $err_string = "Timer expired";
            }
            when (63) {
                $symbol     = "ENOSR";
                $err_string = "Out of streams resources";
            }
            when (64) {
                $symbol     = "ENONET";
                $err_string = "Machine is not on the network";
            }
            when (65) {
                $symbol     = "ENOPKG";
                $err_string = "Package not installed";
            }
            when (66) {
                $symbol     = "EREMOTE";
                $err_string = "Object is remote";
            }
            when (67) {
                $symbol     = "ENOLINK";
                $err_string = "Link has been severed";
            }
            when (68) {
                $symbol     = "EADV";
                $err_string = "Advertise error";
            }
            when (69) {
                $symbol     = "ESRMNT";
                $err_string = "Srmount error";
            }
            when (70) {
                $symbol     = "ECOMM";
                $err_string = "Communication error on send";
            }
            when (71) {
                $symbol     = "EPROTO";
                $err_string = "Protocol error";
            }
            when (72) {
                $symbol     = "EMULTIHOP";
                $err_string = "Multihop attempted";
            }
            when (73) {
                $symbol     = "EDOTDOT";
                $err_string = "RFS specific error";
            }
            when (74) {
                $symbol     = "EBADMSG";
                $err_string = "Bad message";
            }
            when (75) {
                $symbol     = "EOVERFLOW";
                $err_string = "Value too large for defined data type";
            }
            when (76) {
                $symbol     = "ENOTUNIQ";
                $err_string = "Name not unique on network";
            }
            when (77) {
                $symbol     = "EBADFD";
                $err_string = "File descriptor in bad state";
            }
            when (78) {
                $symbol     = "EREMCHG";
                $err_string = "Remote address changed";
            }
            when (79) {
                $symbol     = "ELIBACC";
                $err_string = "Can not access a needed shared library";
            }
            when (80) {
                $symbol     = "ELIBBAD";
                $err_string = "Accessing a corrupted shared library";
            }
            when (81) {
                $symbol     = "ELIBSCN";
                $err_string = ".lib section in a.out corrupted";
            }
            when (82) {
                $symbol     = "ELIBMAX";
                $err_string = "Attempting to link in too many shared libraries";
            }
            when (83) {
                $symbol     = "ELIBEXEC";
                $err_string = "Cannot exec a shared library directly";
            }
            when (84) {
                $symbol     = "EILSEQ";
                $err_string = "Invalid or incomplete multibyte or wide character";
            }
            when (85) {
                $symbol     = "ERESTART";
                $err_string = "Interrupted system call should be restarted";
            }
            when (86) {
                $symbol     = "ESTRPIPE";
                $err_string = "Streams pipe error";
            }
            when (87) {
                $symbol     = "EUSERS";
                $err_string = "Too many users";
            }
            when (88) {
                $symbol     = "ENOTSOCK";
                $err_string = "Socket operation on non-socket";
            }
            when (89) {
                $symbol     = "EDESTADDRREQ";
                $err_string = "Destination address required";
            }
            when (90) {
                $symbol     = "EMSGSIZE";
                $err_string = "Message too long";
            }
            when (91) {
                $symbol     = "EPROTOTYPE";
                $err_string = "Protocol wrong type for socket";
            }
            when (92) {
                $symbol     = "ENOPROTOOPT";
                $err_string = "Protocol not available";
            }
            when (93) {
                $symbol     = "EPROTONOSUPPORT";
                $err_string = "Protocol not supported";
            }
            when (94) {
                $symbol     = "ESOCKTNOSUPPORT";
                $err_string = "Socket type not supported";
            }
            when (95) {
                $symbol     = "EOPNOTSUPP";
                $err_string = "Operation not supported";
            }
            when (96) {
                $symbol     = "EPFNOSUPPORT";
                $err_string = "Protocol family not supported";
            }
            when (97) {
                $symbol     = "EAFNOSUPPORT";
                $err_string = "Address family not supported by protocol";
            }
            when (98) {
                $symbol     = "EADDRINUSE";
                $err_string = "Address already in use";
            }
            when (99) {
                $symbol     = "EADDRNOTAVAIL";
                $err_string = "Cannot assign requested address";
            }
            when (100) {
                $symbol     = "ENETDOWN";
                $err_string = "Network is down";
            }
            when (101) {
                $symbol     = "ENETUNREACH";
                $err_string = "Network is unreachable";
            }
            when (102) {
                $symbol     = "ENETRESET";
                $err_string = "Network dropped connection on reset";
            }
            when (103) {
                $symbol     = "ECONNABORTED";
                $err_string = "Software caused connection abort";
            }
            when (104) {
                $symbol     = "ECONNRESET";
                $err_string = "Connection reset by peer";
            }
            when (105) {
                $symbol     = "ENOBUFS";
                $err_string = "No buffer space available";
            }
            when (106) {
                $symbol     = "EISCONN";
                $err_string = "Transport endpoint is already connected";
            }
            when (107) {
                $symbol     = "ENOTCONN";
                $err_string = "Transport endpoint is not connected";
            }
            when (108) {
                $symbol     = "ESHUTDOWN";
                $err_string = "Cannot send after transport endpoint shutdown";
            }
            when (109) {
                $symbol     = "ETOOMANYREFS";
                $err_string = "Too many references: cannot splice";
            }
            when (110) {
                $symbol     = "ETIMEDOUT";
                $err_string = "Connection timed out";
            }
            when (111) {
                $symbol     = "ECONNREFUSED";
                $err_string = "Connection refused";
            }
            when (112) {
                $symbol     = "EHOSTDOWN";
                $err_string = "Host is down";
            }
            when (113) {
                $symbol     = "EHOSTUNREACH";
                $err_string = "No route to host";
            }
            when (114) {
                $symbol     = "EALREADY";
                $err_string = "Operation already in progress";
            }
            when (115) {
                $symbol     = "EINPROGRESS";
                $err_string = "Operation now in progress";
            }
            when (116) {
                $symbol     = "ESTALE";
                $err_string = "Stale file handle";
            }
            when (117) {
                $symbol     = "EUCLEAN";
                $err_string = "Structure needs cleaning";
            }
            when (118) {
                $symbol     = "ENOTNAM";
                $err_string = "Not a XENIX named type file";
            }
            when (119) {
                $symbol     = "ENAVAIL";
                $err_string = "No XENIX semaphores available";
            }
            when (120) {
                $symbol     = "EISNAM";
                $err_string = "Is a named type file";
            }
            when (121) {
                $symbol     = "EREMOTEIO";
                $err_string = "Remote I/O error";
            }
            when (122) {
                $symbol     = "EDQUOT";
                $err_string = "Disk quota exceeded";
            }
            when (123) {
                $symbol     = "ENOMEDIUM";
                $err_string = "No medium found";
            }
            when (124) {
                $symbol     = "EMEDIUMTYPE";
                $err_string = "Wrong medium type";
            }
            when (125) {
                $symbol     = "ECANCELED";
                $err_string = "Operation canceled";
            }
            when (126) {
                $symbol     = "ENOKEY";
                $err_string = "Required key not available";
            }
            when (127) {
                $symbol     = "EKEYEXPIRED";
                $err_string = "Key has expired";
            }
            when (128) {
                $symbol     = "EKEYREVOKED";
                $err_string = "Key has been revoked";
            }
            when (129) {
                $symbol     = "EKEYREJECTED";
                $err_string = "Key was rejected by service";
            }
            when (130) {
                $symbol     = "EOWNERDEAD";
                $err_string = "Owner died";
            }
            when (131) {
                $symbol     = "ENOTRECOVERABLE";
                $err_string = "State not recoverable";
            }
            when (132) {
                $symbol     = "ERFKILL";
                $err_string = "Operation not possible due to RF-kill";
            }
            when (133) {
                $symbol     = "EHWPOISON";
                $err_string = "Memory page has hardware error";
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