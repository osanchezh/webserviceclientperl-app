#!/usr/bin/perl -w
#author:Sanchez Huerta Octavio, osanchezhuerta@gmail.com

use strict;
use LWP::UserAgent;
use HTTP::Request::Common;

my $datestring = localtime();

print("1.SOAP CLIENT TEST - SERVICIO HR EMPLOYEES\n");
print("2.Time test:" , $datestring , "\n");

my $userAgent = LWP::UserAgent->new(agent => 'perl post');
my $endpoint = 'http://127.0.0.1:8080/employees-hr-ws-web/EmployeesHRServiceHttpSoap11Endpoint';
my $soapaction = '\"urn:consultarSalariesPorRango\"';
my $message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:fac=\"http://facade.web.ws.hr.employees.osanchezhuerta.org/\" xmlns:xsd=\"http://domain.web.ws.hr.employees.osanchezhuerta.org/xsd/\">
   <soapenv:Header/>
   <soapenv:Body>
      <fac:consultarSalariesPorRango>
         <fac:governanceHeaderRequest>
            <xsd:hrHeader>
               <xsd:contextoEntidad></xsd:contextoEntidad>
               <xsd:fechaPeticion></xsd:fechaPeticion>
               <xsd:folio>1</xsd:folio>
               <xsd:idCanal>1</xsd:idCanal>
               <xsd:idEntidad>1</xsd:idEntidad>
               <xsd:idOperacion>1</xsd:idOperacion>
               <xsd:idOrganizacion>1</xsd:idOrganizacion>
               <xsd:idServicio>1</xsd:idServicio>
               <xsd:idSistema>1</xsd:idSistema>
               <xsd:idZona>1</xsd:idZona>
            </xsd:hrHeader>
         </fac:governanceHeaderRequest>
         <fac:consultarSalariesPorRangoInput>
            <fac:lstEmpNo>
               <xsd:empNo>10001</xsd:empNo>
            </fac:lstEmpNo>
            <fac:pageNumber>2</fac:pageNumber>
            <fac:pageSize>2</fac:pageSize>
         </fac:consultarSalariesPorRangoInput>
      </fac:consultarSalariesPorRango>
   </soapenv:Body>
</soapenv:Envelope>";


print "3. Web service Request:" , $message , "\n";


my $response = $userAgent->request(POST $endpoint,
Content_Type => 'text/xml;charset=UTF-8',
SOAP_Action=> $soapaction,
Accept_Encoding => 'gzip,deflate',
Content => $message);

print "4. Web service Fault:" ,  $response->error_as_HTML unless $response->is_success  , "\n";

print "5. Web service Response:" , $response->as_string  , "\n";

print "6. End of test" , "\n";