#!/usr/bin/perl -w
use strict ;

############################################################
### Usage: perl checkstyle_parser.pl project.txt nameOfNewTxt
### ex: perl checkstyle_parser.pl checkstyle_clojure.txt clojure
### output: report_erros.txt report_classes.txt 
###
### Celso A. Uliana Jr - March 2017
############################################################

############################################################
## variables declaration
############################################################
my $file = shift;
my $name = shift;
my $file_error = $name . "_error.txt";
my $file_class = $name . "_class.txt";
my %count_error;
my %count_classes;
my $error_count = 0;
my $class_count = 0;
open TXT , "$file" or die "Couldn't open the file $file\n";
############################################################
## open and parse html file
############################################################
while(<TXT>){
	if(/\](.*\.java):/){
		$count_classes{$1}++;
	}
	if(/\[(\w{6,})\]/){
		$count_error{$1}++;
		$error_count++;
	}
}
close TXT;
############################################################
## print results in two diferent .txt files
############################################################
$class_count = keys %count_classes;
open(my $fh, '>', $file_error);
print $fh "Quantidade total de erros =  $error_count\n";
foreach my $error (sort { $count_error{$a} <=> $count_error{$b} } keys %count_error){
	print $fh "Erro:\n$error\n Frequencia do erro = $count_error{$error}\n";
}
close $fh;
open(my $ff, '>', $file_class);
print $ff "Quantidade total de classes = $class_count\n";
foreach my $class (sort { $count_classes{$a} <=> $count_classes{$b} } keys %count_classes){
	print $ff "Classe:\n$class\nQuantidade de erros nessa classe = $count_classes{$class}\n";
}
close $ff;