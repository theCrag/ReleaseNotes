# ReleaseNotes.pl
use strict;
use JSON;
use Cwd;
use Data::Dumper;
use FindBin qw( $Bin );
use File::Spec::Functions qw( catfile );
use lib catfile $Bin, 'lib';
use HTML::Template;
use LWP::UserAgent;		#this library manages the HTTPS GET request

print "\r\n---TheCrag ReleaseNotes by Paul Hauner---\r\n\r\n";

#The .tmpl template file should be located in the same directory as this script
my $templateFile = getcwd() . '/ReleaseNotes.tmpl';
my $template = HTML::Template->new(filename => $templateFile);

#The response is loaded from github in JSON format
my $ua = LWP::UserAgent->new( ssl_opts => { verify_hostname => 0 } );
my $response = $ua->get("https://api.github.com/repos/theCrag/website/issues?milestone=10&state=closed");
print 'GitHub API GET Response: ' . $response->message . "\r\n\r\n";
if ($response->code != 200) {
  die "Exception: Github Response was not 200 OK"
}

#JSON is parsed to the closest available Perl data structure
my $github_raw = decode_json($response->content);

print "Parsing Issues:\r\n";
#enumerate issues
for my $issue (@$github_raw) {
  print "-Issue " . $issue->{'id'} . ": " . $issue->{'title'} . "\r\n";

  for my $label (keys $issue->{'labels'}) {
    print "--Label: " . $issue->{'labels'}[$label]{'name'} . "\r\n";
  }
  print "\r\n";
}

$template->param(
   STUDENT => [
      { NAME => 'NoClimbs', STATUS => 'Closed' },
      { NAME => 'NoUsers'   , STATUS => 'Closed' },
   ]
);

#Debugging Stuff
#print Dumper(@github_raw);
#print @github_raw[0]->'title';
print $github_raw->[0]{'title'} . "\r\n";


#now write the releasenotes file
open(myfile, '>', 'releasenotes.html');
print myfile $template->output;
close(myfile);

#end of script
print "\r\nDone.\r\n";
