#!/usr/bin/perl

use strict;
use warnings;

# create mnemonic password
sub mnemonic {
    my @vow = qw(a e i o u);
    my @con = qw(b c d f g h j k l m n p r s t v w z);
    my $c = 2;
    my $pass = "";
    $pass .= $con[int(rand(18))] . $vow[int(rand(5))] while($c--);
    return $pass;
}

# store user/pass in LaTeX file
sub latex_nametags {
    my $list = shift; # hashref
    open my $f, '>>', 'latex/users.tex';
    foreach my $u (sort keys %$list) {
        print $f "\\begin{minipage}{9cm}\n";
        print $f "Nutzer: \\texttt{$u}\\\\\n";
        print $f "Passwort: \\texttt{" . $$list{$u} . "}\n";
        print $f "\\end{minipage}";
        print $f "\\vspace{.7cm}\n";
        print $f "\n" if $u =~ /[24680]$/;
    }
    close $f;
}

# change passwords for multiple users at once
sub chpasswd {
    my $users = shift;
    open my $c, '|-', 'chpasswd';
    print $c $_ . ':' . $$users{$_} . "\n" foreach(sort keys %$users);
    close $c;
}


$|=1;
my %users = ();
my $USERS = 20;
$USERS = int($ARGV[0]) if($ARGV[0] && $ARGV[0] =~ /^\d+$/);

# check EUID
if($> != 0) {
    print STDERR "Must be run with root privileges!\n";
    exit 1;
}

# check latex dir
if(-d "latex") {
    qx(rm latex/users.tex 2>/dev/null);
} else {
    print STDERR "No latex/ directory found!\n";
    exit 2;
}

for(my $i=1; $i<=$USERS; $i++) {
    my $user = sprintf("tn%02d", $i);
    my $pass = mnemonic();
    print "creating user $user with password $pass ... ";
    qx(useradd -d /repos/$user --shell /usr/bin/git-shell $user);
    $users{$user} = $pass;

    print " cloning blessed git repo ... ";
    qx(cd /repos; git clone --bare /repos/git-tips $user >/dev/null; chown -R $user:$user $user);
    print "done.\n";
}

chpasswd(\%users);
latex_nametags(\%users);

print "generating user/password cards... ";
qx(cd latex; pdflatex nametags >/dev/null; rm nametags.aux nametags.log );
print "done.\n\n";

__END__
