#!/usr/bin/perl -w
#author:Sanchez Huerta Octavio, osanchezhuerta@gmail.com

use strict;
use warnings;

use LWP::UserAgent;
use HTTP::Request::Common;

my $datestring = localtime();
print("0. Begin test");
print("1. SOAP CLIENT TEST - SERVICIO HR EMPLOYEES\n");
print("2. Time test:" , $datestring , "\n");

#Required input data
my $filename = 'consultarSalariesPorRangoRequest.xml';
my $endpoint = 'http://127.0.0.1:8080/employees-hr-ws-web/EmployeesHRServiceHttpSoap11Endpoint';
my $soapaction = '\"urn:consultarSalariesPorRango\"';

open(my $fileopenrequest, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
my $data = do { local $/; <$fileopenrequest> };

my $userAgent = LWP::UserAgent->new(agent => 'perl post');
my $message = $data;


print "3. Web service Request:" , $message , "\n";


my $response = $userAgent->request(POST $endpoint,
Content_Type => 'text/xml;charset=UTF-8',
SOAP_Action=> $soapaction,
Accept_Encoding => 'gzip,deflate',
Content => $message);

print "4. Web service Fault:" ,  $response->error_as_HTML unless $response->is_success  , "\n";

print "5. Web service Response:" , $response->as_string  , "\n";

print "6. End of test" , "\n";