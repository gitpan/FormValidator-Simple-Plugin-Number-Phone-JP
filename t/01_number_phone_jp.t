use strict;
use Test::More tests => 26;
use CGI;

use FormValidator::Simple;
FormValidator::Simple->import('Number::Phone::JP');

my $q = CGI->new;
my $line = 13;

for (1..$line) {
	my $num = <DATA>;
	chomp $num;
	$q->param( tel => $num );
	my $r = FormValidator::Simple->check( $q => [
						     tel => [qw/NUMBER_PHONE_JP/],
						     ] );
	ok(!$r->invalid('tel'));
}

while (<DATA>) {
	chomp;
	$q->param( tel => $_ );
	my $r = FormValidator::Simple->check( $q => [
						     tel => [qw/NUMBER_PHONE_JP/],
						     ] );
	ok($r->invalid('tel'));
}

__DATA__
011 1234567
0164 123456
01646 12345
01652 12345
016528 1234
01653 12345
016532 1234
016534 1234
03 12345678
04 12345678
06 12345678
0460 12345
0578 12345
011 123456
0164 12345
01646 1234
01652 1234
016528 123
01653 1234
016532 123
016534 123
03 1234567
04 1234567
06 1234567
0460 123456
0578 123456
