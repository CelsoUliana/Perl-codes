############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################
#!/usr/bin/perl

sub lonelyinteger {
    %hash;
    foreach $num(@_){
        $hash{$num}++;
    }
    
    foreach $key(keys %hash){
        if($hash{$key} == 1){
            return $key;
        }
    }
    
}

$n = <STDIN>;
chomp $n;
$a_temp = <STDIN>;
@a = split / /,$a_temp;
chomp @a;
$result = lonelyinteger(@a);
print "$result\n";

