Regular Expressions in R
========================================================
date: 10 November 2017
width: 1600
height: 700

Basics
========================================================

- find patterns in text
- "wildcard on steroids"
- usage across programming languages and in many text editors

From [Wikipedia](https://en.wikipedia.org/wiki/Regular_expression)

    a sequence of characters that define a search pattern. Usually this
    pattern is then used by string searching algorithms for "find" or "find
    and replace" operations on strings.

Useful links
========================================================

* [cheat sheet](https://www.cheatography.com/davechild/cheat-sheets/regular-expressions/pdf/)
* [regex tester](https://regex101.com/) - super useful
* [detailed info](https://www.regular-expressions.info/)


In R
========================================================


```r
sonnet18 <- readRDS("data/sonnet18.rds")
sonnet18
```

```
[1] "  Shall I compare thee to a summer's day?   Thou art more lovely and more temperate:   Rough winds do shake the darling buds of May,   And summer's lease hath all too short a date:   Sometime too hot the eye of heaven shines,   And often is his gold complexion dimmed,   And every fair from fair sometime declines,   By chance, or nature's changing course untrimmed:   But thy eternal summer shall not fade,   Nor lose possession of that fair thou ow'st,   Nor shall death brag thou wand'rest in his shade,   When in eternal lines to time thou grow'st,     So long as men can breathe or eyes can see,     So long lives this, and this gives life to thee.                       "
```

In R - gsub() - basics
========================================================


```r
gsub(pattern = "art", replacement = "are", sonnet18)
```

```
[1] "  Shall I compare thee to a summer's day?   Thou are more lovely and more temperate:   Rough winds do shake the darling buds of May,   And summer's lease hath all too short a date:   Sometime too hot the eye of heaven shines,   And often is his gold complexion dimmed,   And every fair from fair sometime declines,   By chance, or nature's changing course untrimmed:   But thy eternal summer shall not fade,   Nor lose possession of that fair thou ow'st,   Nor shall death brag thou wand'rest in his shade,   When in eternal lines to time thou grow'st,     So long as men can breathe or eyes can see,     So long lives this, and this gives life to thee.                       "
```

In R - gsub() - correct line breaks
========================================================


```r
s18_clean <- gsub(pattern = ",\\s{2,}", replacement = ",\n", sonnet18)
cat(s18_clean)
```

```
  Shall I compare thee to a summer's day?   Thou art more lovely and more temperate:   Rough winds do shake the darling buds of May,
And summer's lease hath all too short a date:   Sometime too hot the eye of heaven shines,
And often is his gold complexion dimmed,
And every fair from fair sometime declines,
By chance, or nature's changing course untrimmed:   But thy eternal summer shall not fade,
Nor lose possession of that fair thou ow'st,
Nor shall death brag thou wand'rest in his shade,
When in eternal lines to time thou grow'st,
So long as men can breathe or eyes can see,
So long lives this, and this gives life to thee.                       
```

In R - gsub() - grouping and `|` as OR
========================================================


```r
s18_clean <- gsub(
  pattern = "(,\\s{2,}|:\\s{2,}|\\?\\s{2,})",
  replacement = "\n", sonnet18)
cat(s18_clean)
```

```
  Shall I compare thee to a summer's day
Thou art more lovely and more temperate
Rough winds do shake the darling buds of May
And summer's lease hath all too short a date
Sometime too hot the eye of heaven shines
And often is his gold complexion dimmed
And every fair from fair sometime declines
By chance, or nature's changing course untrimmed
But thy eternal summer shall not fade
Nor lose possession of that fair thou ow'st
Nor shall death brag thou wand'rest in his shade
When in eternal lines to time thou grow'st
So long as men can breathe or eyes can see
So long lives this, and this gives life to thee.                       
```
***

```r
print(s18_clean)
```

```
[1] "  Shall I compare thee to a summer's day\nThou art more lovely and more temperate\nRough winds do shake the darling buds of May\nAnd summer's lease hath all too short a date\nSometime too hot the eye of heaven shines\nAnd often is his gold complexion dimmed\nAnd every fair from fair sometime declines\nBy chance, or nature's changing course untrimmed\nBut thy eternal summer shall not fade\nNor lose possession of that fair thou ow'st\nNor shall death brag thou wand'rest in his shade\nWhen in eternal lines to time thou grow'st\nSo long as men can breathe or eyes can see\nSo long lives this, and this gives life to thee.                       "
```

In R - gsub() - using a list of characters
========================================================


```r
s18_clean <- gsub(pattern = "[,?:]\\s{2,}",
                  replacement = "\n", sonnet18, perl = TRUE)
cat(s18_clean)
```

```
  Shall I compare thee to a summer's day
Thou art more lovely and more temperate
Rough winds do shake the darling buds of May
And summer's lease hath all too short a date
Sometime too hot the eye of heaven shines
And often is his gold complexion dimmed
And every fair from fair sometime declines
By chance, or nature's changing course untrimmed
But thy eternal summer shall not fade
Nor lose possession of that fair thou ow'st
Nor shall death brag thou wand'rest in his shade
When in eternal lines to time thou grow'st
So long as men can breathe or eyes can see
So long lives this, and this gives life to thee.                       
```

In R - gsub() - refering back to group
========================================================


```r
s18_clean <- gsub(pattern = "(,|\\?|:)\\s{2,}",
                  replacement = "\\1\n", sonnet18)
cat(s18_clean)
```

```
  Shall I compare thee to a summer's day?
Thou art more lovely and more temperate:
Rough winds do shake the darling buds of May,
And summer's lease hath all too short a date:
Sometime too hot the eye of heaven shines,
And often is his gold complexion dimmed,
And every fair from fair sometime declines,
By chance, or nature's changing course untrimmed:
But thy eternal summer shall not fade,
Nor lose possession of that fair thou ow'st,
Nor shall death brag thou wand'rest in his shade,
When in eternal lines to time thou grow'st,
So long as men can breathe or eyes can see,
So long lives this, and this gives life to thee.                       
```

In R - gsub() - the simplest solution
========================================================


```r
s18_clean <- gsub(pattern = "\\s{2,}",
                  replacement = "\n", sonnet18)
cat(s18_clean)
```

```

Shall I compare thee to a summer's day?
Thou art more lovely and more temperate:
Rough winds do shake the darling buds of May,
And summer's lease hath all too short a date:
Sometime too hot the eye of heaven shines,
And often is his gold complexion dimmed,
And every fair from fair sometime declines,
By chance, or nature's changing course untrimmed:
But thy eternal summer shall not fade,
Nor lose possession of that fair thou ow'st,
Nor shall death brag thou wand'rest in his shade,
When in eternal lines to time thou grow'st,
So long as men can breathe or eyes can see,
So long lives this, and this gives life to thee.
```


In R - grep()
========================================================


```r
sonnets <- readRDS("data/sonnets.rds")
grep(pattern = "love", x = sonnets)
```

```
 [1]   3   4   5   9  10  13  15  18  19  20  21  22  23  25  26  29  30
[18]  31  32  33  34  35  36  37  39  40  42  45  46  47  49  50  51  54
[35]  55  56  57  61  62  63  64  65  66  70  71  72  73  76  79  80  82
[52]  85  88  89  91  92  93  95  96  99 100 101 102 105 106 107 108 109
[69] 110 112 114 115 116 117 118 119 122 124 126 130 131 132 136 138 139
[86] 140 141 142 144 147 148 149 150 151 152 153 154
```

```r
grepl(pattern = "love", x = sonnets)
```

```
  [1] FALSE FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE
 [12] FALSE  TRUE FALSE  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
 [23]  TRUE FALSE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
 [34]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE
 [45]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE
 [56]  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
 [67] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE  TRUE FALSE
 [78] FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE
 [89]  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE FALSE FALSE  TRUE
[100]  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
[111] FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE
[122]  TRUE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE  TRUE
[133] FALSE FALSE FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE
[144]  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
```


In R - grep()
========================================================

Which sonnets contain the string `"I love"`?


```r
grep(pattern = "I love", x = sonnets)
```

```
 [1]  31  36  42  71  96 102 115 130 132 142 149 150
```

Which sonnets contain at least one `"love"` **without** the string `"I "` in front.


```r
grep(pattern = "(?<!I )love", x = sonnets, perl = TRUE)
```

```
 [1]   3   4   5   9  10  13  15  18  19  20  21  22  23  25  26  29  30
[18]  31  32  33  34  35  36  37  39  40  42  45  46  47  49  50  51  54
[35]  55  56  57  61  62  63  64  65  66  70  71  72  73  76  79  80  82
[52]  85  88  89  91  92  93  95  96  99 100 101 102 105 106 107 108 109
[69] 110 112 114 115 116 117 118 119 122 124 126 130 131 136 138 139 140
[86] 141 142 144 147 148 149 150 151 152 153 154
```


More cheat sheets
========================================================

* https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf
* https://github.com/rstudio/cheatsheets/raw/master/strings.pdf

