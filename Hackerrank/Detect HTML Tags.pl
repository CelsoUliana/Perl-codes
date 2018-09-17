############################################################
### Celso A. Uliana Jr - Feb 2017
############################################################

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

@arr;
foreach $line (<STDIN>) {
    chomp( $line );
    $_ = $line;
        
    my @matches = $line =~ m/<(\w+)/g;
        
    $count = scalar(@matches);
        
    if($count > 0){
        foreach $match(@matches){
            #print "$match";
            $atual = $match;
            
            $atual =~ s/^\s+|\s+$//g;

            
            push @arr, $atual;
        }
    }
}

@array = uniq(@arr);
@array = sort(@array);

$cont = scalar(@array);

foreach $item(@array){
    $cont--;
    print "$item;" if $cont > 0;
    print "$item"  if $cont == 0;
}
