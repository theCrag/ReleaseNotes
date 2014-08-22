# ReleaseNotes.pl
use JSON;
use Cwd;
use FindBin qw( $Bin );
use File::Spec::Functions qw( catfile );
use lib catfile $Bin, 'lib';
use HTML::Template;
use LWP::UserAgent;		#this library manages the HTTPS GET request


#The .tmpl template file should be located in the same directory as this script
my $templateFile = getcwd() . '/ReleaseNotes.tmpl';
my $template = HTML::Template->new(filename => $templateFile);

#The response is loaded from github in JSON format
my $ua = LWP::UserAgent->new( ssl_opts => { verify_hostname => 0 } );
my $response = $ua->get("https://api.github.com/repos/theCrag/website/issues?milestone=10&state=closed");
print 'GitHub API GET Response: ' . $response->message . "\r\n";

#JSON is parsed to the closest available Perl data structure
my $github_raw = decode_json($response->content);


$template->param(
   STUDENT => [
      { NAME => 'NoClimbs', STATUS => 'Closed' },
      { NAME => 'NoUsers'   , STATUS => 'Closed' },
   ]
);

#print the results to stdoutput
#print $template->output;
#print $response->status_line;
#print $response->content  . "\r\n";
print join(", ", @github_raw);

#now write the releasenotes file
open(myfile, '>', 'releasenotes.html');
print myfile $template->output;
close(myfile);

#end of script
print "Done.\r\n";