#!/usr/bin/perl

use strict;
use warnings;

use utf8;
use Template;
use File::Slurper 'read_binary';
use MIME::Base64;

my $OUT = "html";

my $t = Template->new({
		INCLUDE_PATH => 'src',
		ENCODING => 'utf8',
		VARIABLES => {
     raptor => imgdata('failraptor.png'),
   },
});

my %stranky = (
	'401' => 'Přihlášení nutné',
	'404' => 'Stránka nenalezena',
	'403' => 'Přístup zakázán',
	'500' => 'Služba je dočasně nedostupná',
);

for my $foo (keys %stranky){
	$t->process("error.html",
	{ 
		'title' => $stranky{$foo},
	},
	"$OUT/$foo.html",
	{ binmode => ':utf8' }) or die $t->error;
};

sub imgdata{

	my $filename = shift;

	return "data:image/png;base64,".encode_base64(read_binary("img/$filename"));

}
