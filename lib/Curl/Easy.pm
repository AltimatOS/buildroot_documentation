package Curl::Easy {
    use strictures;
    use utf8;
    use English;

    use feature ":5.26";
    no warnings "experimental::signatures";
    no warnings "experimental::smartmatch";
    use feature "lexical_subs";
    use feature "signatures";
    use feature "switch";

    use boolean;
    use Throw qw(throw classify);
    use Try::Tiny qw(try catch);

    use FindBin;
    use lib "$FindBin::Bin/../lib";

    use Sys::Error;

    $Throw::trace  = 1;
    $Throw::pretty = 1;

    my $error        = undef;

    my $follow       = false;
    my $progress_bar = false;

    sub new ($class, $flags) {
        my $self = {};

        # instantiate classes
        $error = Sys::Error->new();

        # assign private attributes
        $follow       = $flags->{'follow'};
        $progress_bar = $flags->{'progress_bar'};

        bless($self, $class);
        return $self;
    }

    our sub get_follow ($self) {
        return $follow;
    }
    our sub set_follow ($self, $attribute) {
        $follow = $attribute;
    }

    our sub get_progress_bar ($self) {
        return $progress_bar;
    }
    our sub set_progress_bar ($self, $attribute) {
        $progress_bar = $attribute;
    }

    our sub fetch_file ($self, $url, $file) {
        my $retval = undef;
        try {
            if ($follow eq true) {
                if ($progress_bar eq true) {
                    system('curl', '-L', '-#', '--url', "${uri}/${file_name}", '--output', ${file_name});
                    $retval = $CHILD_ERROR >> 8;
                } else {
                    system('curl', '-L', '--url', "${uri}/${file_name}", '--output', ${file_name});
                    $retval = $CHILD_ERROR >> 8;
                }
            } else {
                if ($progress_bar eq true) {
                    system('curl', '-#', '--url', "${uri}/${file_name}", '--output', ${file_name});
                    $retval = $CHILD_ERROR >> 8;
                } else {
                    system('curl', '--url', "${uri}/${file_name}", '--output', ${file_name});
                    $retval = $CHILD_ERROR >> 8;
                }
            }
            if ($retval != 0) {
                throw "Child Error", {
                    'trace' => 3,
                    'info'  => "Attempted to fetch '$url' -> '$file'",
                    'type'  => $retval,
                    'code'  => $retval
                };
            }
        } catch {
            classify $ARG, {
                1   => sub {
                    # this is fatal
                    $error->err_msg($ARG, "Unsupported Protocol");
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => 'Unsupported Protocol'
                    }
                },
                2   => sub {
                    # fatal
                    $class = "Failed to Initialize";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                3   => sub {
                    # fatal
                    $class = "Malformed URL";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                4   => sub {
                    # fatal
                    $class = "Missing Feature";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                5   => sub {
                    # potential for retry logic
                    $class = "Proxy DNS Resolution Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                6   => sub {
                    # potential for retry logic
                    $class = "Host DNS Resolution Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                7   => sub {
                    # potential for retry logic
                    $class = "Host Connection Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                8   => sub {
                    # potential for retry logic
                    $class = "Inconsistent Host Response";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                9   => sub {
                    # fatal
                    $class = "FTP Access Denied";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                10  => sub {
                    # potential for retry logic
                    $class = "FTP Accept Request Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                11  => sub {
                    # potential for retry logic
                    $class = "FTP Inconsistent PASS Reply";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                12  => sub {
                    # potential for retry logic
                    $class = "FTP Connection Timeout";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                13  => sub {
                    # potential for retry logic
                    $class = "FTP Inconsistent PASV Reply";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                14  => sub {
                    # potential for retry logic
                    $class = "FTP Inconsistent 227 Format";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                15  => sub {
                    # potential for retry logic
                    $class = "FTP 227 Host Resolution Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                16  => sub {
                    # potential for retry logic, but could be fatal.
                    #  Will need to work out sub errors for this.
                    $class = "Generic HTTP/2 Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                17  => sub {
                    # non-fatal, just warn
                    $class = "FTP: Cannot Set Binary Mode";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                18  => sub {
                    # potential for retry logic
                    $class = "Incomplete File Transfer";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                19  => sub {
                    # potential for retry logic
                    $class = "FTP: Generic RETR Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                21  => sub {
                    # fatal
                    $class = "FTP: Quote Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                22  => sub {
                    # fatal
                    $class = "Generic HTTP Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                23  => sub {
                    # fatal
                    $class = "Local Filesystem I/O Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                25  => sub {
                    # fatal
                    $class = "FTP STOR Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                26  => sub {
                    # fatal
                    $class = "Generic Read Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                27  => sub {
                    # fatal
                    $class = "Out of Memory";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                28  => sub {
                    # fatal
                    $class = "Operation Timed Out";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                30  => sub {
                    # retry logic for ACTIVE/PASV needed
                    $class = "FTP PORT Request Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                31  => sub {
                    # fatal
                    $class = "FTP REST Request Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                33  => sub {
                    # non-fatal, need to emit a warning
                    $class = "HTTP RANGE Request Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                34  => sub {
                    # potential for retry logic
                    $class = "HTTP POST Request Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                35  => sub {
                    # fatal
                    $class = "SSL Handshake Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                36  => sub {
                    # fatal
                    $class = "Unable to Resume Download";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                37  => sub {
                    # fatal
                    $class = "Local File Access Denied";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                38  => sub {
                    # fatal
                    $class = "LDAP Bind Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                39  => sub {
                    # fatal
                    $class = "LDAP Search Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                41  => sub {
                    # fatal
                    $class = "LDAP Server Function Not Found";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                42  => sub {
                    # fatal
                    $class = "Client Abort";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                43  => sub {
                    # fatal
                    $class = "LibCurl Internal Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                45  => sub {
                    # fatal
                    $class = "System Interface Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                47  => sub {
                    # fatal
                    $class = "Redirection Limit";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                48  => sub {
                    # fatal
                    $class = "LibCurl Invalid Option";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                49  => sub {
                    # fatal
                    $class = "Invalid Telnet Option";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                51  => sub {
                    # fatal
                    $class = "Invalid PKI Fingerprint (SSL/SSH)";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                52  => sub {
                    # potential retry logic needed
                    $class = "No Response From Server";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                53  => sub {
                    # fatal
                    $class = "Missing SSL Cryptography Engine";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                54  => sub {
                    # fatal
                    $class = "Cannot set Default SSL Cryptography Engine";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                55  => sub {
                    # potential retry logic needed
                    $class = "Transient Packet Send Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                56  => sub {
                    # potential retry logic needed
                    $class = "Transient Packet Recieve Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                58  => sub {
                    # fatal
                    $class = "Local System Certificate Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                59  => sub {
                    # fatal
                    $class = "Unable to use SSL Cipher";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                60  => sub {
                    # fatal
                    $class = "Peer Certificate Trust Chain Broken";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                61  => sub {
                    # fatal
                    $class = "Unknown Transfer Encoding";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                62  => sub {
                    # fatal
                    $class = "Invalid LDAP URI";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                63  => sub {
                    # fatal
                    $class = "Maximum File Size Exceeded";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                64  => sub {
                    # fatal
                    $class = "Requested FTP SSL Level Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                65  => sub {
                    # fatal
                    $class = "Cannot Resume Sending Data";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                66  => sub {
                    # fatal
                    $class = "Failed to Initialize SSL Engine";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                67  => sub {
                    # fatal
                    $class = "Authentication Error: Invalid Username or Password";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                68  => sub {
                    # fatal
                    $class = "TFTP: File Not Found";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                69  => sub {
                    # fatal
                    $class = "TFTP: Access Denied";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                70  => sub {
                    # fatal
                    $class = "TFTP: No Disk Space Available";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                71  => sub {
                    # fatal
                    $class = "TFTP: Illegal Operation";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                72  => sub {
                    # fatal
                    $class = "TFTP: Invalid Transfer ID";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                73  => sub {
                    # non-fatal, throw warning
                    $class = "TFTP: File Already Exists";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                74  => sub {
                    # fatal
                    $class = "TFTP: No Such User";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                75  => sub {
                    # fatal
                    $class = "Encoding Conversion Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                76  => sub {
                    # fatal
                    $class = "Encoding Conversion Feature Unavailable";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                77  => sub {
                    # fatal
                    $class = "Unable to Read SSL Certificate";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                78  => sub {
                    # fatal
                    $class = "Resource Unavailable";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                79  => sub {
                    # fatal
                    $class = "SSH: Unspecified Session Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                80  => sub {
                    # fatal
                    $class = "Unable to Close SSL Connection";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                82  => sub {
                    # fatal
                    $class = "Unable to Read CRL File";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                83  => sub {
                    # fatal
                    $class = "PKI Issuer Validation Failed";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                84  => sub {
                    # fatal
                    $class = "FTP PRET Command Failure";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                85  => sub {
                    # fatal
                    $class = "RTSP: CSeq Mismatch";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                86  => sub {
                    # fatal
                    $class = "RTSP: Seesion ID Mismatch";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                87  => sub {
                    # fatal
                    $class = "FTP: Unable to Parse File List";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                88  => sub {
                    # fatal
                    $class = "FTP: Chunk Callback Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                89  => sub {
                    # fatal
                    $class = "No Connection Available";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                90  => sub {
                    # fatal
                    $class = "SSH: Public Key Mis-match";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                91  => sub {
                    # fatal
                    $class = "Invalid SSL Certificate";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                },
                92  => sub {
                    # fatal
                    $class = "HTTP/2 Framing Layer Stream Error";
                    $err_msg->err_msg($ARG, $class);
                    throw $ARG->{'error'}, {
                        'trace' => 3,
                        'type'  => $ARG->{'type'},
                        'code'  => $ARG->{'type'},
                        'msg'   => $class
                    }
                }
            };
        }
    }

    true;
}