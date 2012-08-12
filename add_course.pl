#!/usr/bin/perl -w
# This script prompts a user for their Potsdam username, password, and a Course
# Registration Number and attempts to register them for the course.  If
# registration is unsuccessful, the user has the choice to continue attempting
# to add the course at time intervals specified by the user.

# this script depends that you have the ``perl-lwp-protocol-https", among other
# packages installed

use strict;
use WWW::Mechanize;
use Term::ReadKey;

# takes in an WWW::mechanize::Link object and prints out all the links... use
# it like so: print_links($agent->links()) where $agent is the WWW::mechanize
# object that is patrolling an HTML page
sub print_links() {
    print "Links:\n";
    while (@_) {
        print shift->url . "\n";
    }
}

# takes in a URL string and prints it in a recognizable way
sub print_URL() {
    print "... " . shift . " ...\n";
}

## collect login information from user
print "Username: ";
my $USERNAME = <STDIN>; chomp $USERNAME;
print "Password: ";
ReadMode 'noecho';
my $PASSWORD = <STDIN>; chomp $PASSWORD;
ReadMode 'normal';
print "\nCRN: ";
my $CRN = <STDIN>; chomp $CRN;
my $bearpaws_URL = "https://services.potsdam.edu/prod/twbkwbis.P_WWWLogin";

# create a new WWW::Mechanize object that will read in HTML pages
my $agent = WWW::Mechanize->new();

# move to the BearPaws login page
$agent->get($bearpaws_URL);
&print_URL( $agent->title );

# choose the right form to be in
$agent->form_name('loginform');
# fill in the username & password for the student
$agent->field(sid => $USERNAME);
$agent->field(PIN => $PASSWORD);

# click the `login' button
$agent->click_button( value => 'Login');

# for some reason, clicking the login button does not bring us to the next page.
# the URL for the next page is contained in array returned by the links() method.
# so, in order to get to the next page, we just load this URL manually
my $http_object = shift $agent->links();
my $url = $http_object->url;
$agent->get($url);

# #############################################################
# Now traverse to the Add/Drop menu along the following path: #
# Student Service & Financial Aid ->                          #
#  Registation ->                                             #
#   Add or Drop Classes ->                                    #
#    *Click* the `Submit' button                              #
###############################################################

# Student Service & Financial Aid
$agent->follow_link( url_regex => qr/StuMainMnu/ );
&print_URL($agent->title);

# Registation
$agent->follow_link( url_regex => qr/RegMnu/ );
&print_URL($agent->title);

# Add or Drop Classes
$agent->follow_link( url_regex => qr/AltPin/ );
&print_URL($agent->title);

# now we need to *click* the `Submit' button, so tell agent we need to be on
# form 2
$agent->form_number(2);
# *click* the `Submit' button
$agent->click_button( value => 'Submit' );
&print_URL($agent->title);

# check to see if student is already registered for the course
die "You are already registered for CRN $CRN\n" unless ($agent->content !~
    /$CRN/);

# try and register the student for the course
$agent->form_number(2);
# input the CRN of the class we want to add into the 7th field called `CRN_IN'
$agent->field( 'CRN_IN',  $CRN, 7 );
# *click* the button called `REG_BTN'
$agent->click_button( name => 'REG_BTN' );

if ($agent->content =~ /Registration Add Errors/i || $agent->content !~ /${CRN}/) {
    print "Your course was unable to be added.  Would you like to keep trying
to add the course? [y/n] ";
    my $response = <STDIN>;
    if ($response =~ /n/i) {
        die "Better luck next time!\n";
    } else {
        print "How often would you like to try registering for the course (in
seconds)? [ex. 30] ";
        my $time = <STDIN>;
        # test to see if the course was successfully added...
        # sometimes the resulting HTML document shows that there is a ``Registration
        # Add Error" description, so that's a sure-fire way to know the addition
        # failed.  sometimes the HTML document does not tell us, so how are we to know
        # of a failure?  well, in a successful addition of a course, the resulting HMTL
        # document will show that the course is know among the ones added... so if the
        # CRN # is part of the resulting HTML document, the course was added
        # successfully
        while ($agent->content =~ /Registration Add Errors/i || $agent->content !~ /${CRN}/) {
            if ($agent->content =~ /Registration Add Errors/i) {
                print "Resistration Error--trying again...";
            } else {
                print "The CRN was not found in the HTML document, trying again...\n";
            }
            sleep $time;
            $agent->form_number(2);
            # input the CRN of the class we want to add into the 7th field called `CRN_IN'
            $agent->field( 'CRN_IN',  $CRN, 7 );
            # *click* the button called `REG_BTN'
            $agent->click_button( name => 'REG_BTN' );
        }
    }
}
print "You have successfully been registered for CRN $CRN!\n";
