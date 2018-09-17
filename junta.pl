#!/usr/bin/perl -w
use strict;
 
############################################################
### Usage: junta.pl list.txt
### ex: junta.pl leak.txt
### output: leak_violations/class.csv  
###
### Celso A. Uliana Jr - July 2017
############################################################
############################################################
## sub de contar os zeros e inserir no final
## e em seguida ordenar por esse numero.
############################################################
sub ordena{
    my @multi = @_ ;
    my $num_global;
    for my $ref (@multi) {
        my $num = scalar @$ref - 1 ;
        $num_global = $num ;
        my $iterator = 0 ;
        my $zero_count = 0 ;
        for my $inner (@$ref) {
            if($iterator != 0){
               if($inner == 0 ){
                    $zero_count++ ;
                }
                if($iterator == $num ){
                    push @$ref , $zero_count ; 
                }
            }
            $iterator++ ;
        }
    }
    $num_global++;
    my @sorted = sort { $a->[$num_global] <=> $b->[$num_global] } @multi ;
    return @sorted ;
}
############################################################
## declaração de variáveis
############################################################
my $file = shift;
my %hash;
my %temp;
my @files;
my @new;
my @data;
my $atual      = 0 ;
my $num_chaves = 0 ;
my $count      = 0 ;
############################################################
## cria a hash com os arquivos .csv pela hash
############################################################
open TXT, "$file" or die "cant open $file\n";
while(<TXT>){
    chomp;
    my $aux = $_ . "_violacoes.csv";
    push @files, $aux ;
    open CSV, "$aux" or die "can't open '$_\n" ;
    while (<CSV>) {
        chomp;
        my @t              = split ';' ;
        $hash{$t[0]}{$aux} = $t[1] ;
    }
}
close CSV;
close TXT;
############################################################
## joga os arquivos da hash em um array p/ ordenar
############################################################
foreach my $violation ( keys %hash ) {
    my @row;
    push @row, $violation ;
    $atual      = 1 ;
    $num_chaves = scalar @files ;
 
    foreach my $version (@files) {
        if ( $atual == $num_chaves ) {
            if ( exists $hash{$violation}{$version} ) {
                push @row, int( $hash{$violation}{$version});
            }
            else {
                push @row, int(0);
 
            }
        }
        else {
            if ( exists $hash{$violation}{$version} ) {
                push @row, int($hash{$violation}{$version}) ;
            }
            else {
                push @row, int(0) ;
            }
        }
        $atual++ ;
    }
     push @data, \@row;
}
############################################################
## printa em um novo arquivo .csv ordenado
############################################################
@new   = ordena(@data) ;
$count = 0;
open( my $fh, '>', "junto.csv" ) ;
for my $ref (@new) {
    print $fh "\n" if ( $count != 0);
    pop $ref;
    $count = 0;
    for my $inner (@$ref) {
        $count++;
        print $fh $inner . " ; " if($count != scalar @$ref) ;
        print $fh $inner if($count == scalar @$ref);
    }
}
close $fh;
exit();