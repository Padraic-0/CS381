my $title = "Papa Was Papa Was a Rolling Papa here Papa no Papa yes Papa no Stone an by Was Rolling the with of his from on the apple";
$_ = $title;
$_ ~~ s:g:i/<|w>a<|w>\s//;
$_ ~~ s:g:i/<|w>an<|w>\s//;
$_ ~~ s:g:i/<|w>and<|w>\s//;
$_ ~~ s:g:i/<|w>by<|w>\s//;
$_ ~~ s:g:i/<|w>for<|w>\s//;
$_ ~~ s:g:i/<|w>from<|w>\s//;
$_ ~~ s:g:i/<|w>in<|w>\s//;
$_ ~~ s:g:i/<|w>of<|w>\s//;
$_ ~~ s:g:i/<|w>on<|w>\s//;
$_ ~~ s:g:i/<|w>or<|w>\s//;
$_ ~~ s:g:i/<|w>out<|w>\s//;
$_ ~~ s:g:i/<|w>the<|w>\s//;
$_ ~~ s:g:i/<|w>to<|w>\s//;
$_ ~~ s:g:i/<|w>with<|w>\s//;
print($_,"\n");
my @titles = ();
@titles.push($_);
my %counts = ();
for @titles -> $title {
		$_ = $title;
		#print($title,"\n");
		my @words = $_ ~~ m:g/<|w>\S+<|w>/;
		#print(@words,"\n");
		my $title_len = @words.elems;
		if ($title_len > 1) {
			for @words.kv -> $index, $word {
				my $next_index = $index + 1;
				if $next_index < $title_len {
					my $next_word = @words[$next_index];
					%counts{$word}{$next_word}++;
					

				}
			}
		}
	}

print(%counts,"\n");
my %word_history = ();
my $word = "Papa";
# Store the most common next word in this variable and return it.
my $best_word = '';
my @best_words = %counts{$word}.keys.sort({ %counts{$word}{$_} }).reverse;
print(@best_words);
print("\n############here#################\n");
@best_words =();#%counts{$word}.keys.sort({-%counts{$word}{$_}});
my $max = 0;
for %counts{$word}.kv -> $key, $value {
    if %word_history{$key}:exists {
			next;
    }
    if $value > $max {
        $max = $value;
        $best_word = $key;
    }
}
%word_history = ();
print($best_word);
print("\n############here#################\n");
print("\n#############################\n");
print($word, "\n");
print(@best_words);
print("\n#############################");
#print @best_words;
#say @best_words;
for @best_words -> $possible_word {
    if %word_history{$possible_word}:exists {
        next;
    } else {
        $best_word = $possible_word;
        %word_history{$best_word} = True;
        last;
    }
}

