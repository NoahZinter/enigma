# enigma

## Functionality
  I think I scored a 3 on functionality. I didn't touch the cracking method, but my encrypt/decrypt methods work and my CLI works as expected.

## Object Oriented Programming
  I score myself a 2.5 here. I have some repition in my encrypt/decrypt methods and my encode_message/decode_message methods that I tried to refactor out or move to a module, but since those methods call other methods which have arguments I was unable to extract them in that way without creating argument errors in the helper methods. I also dislike having @key and @offset as instance variables in enigma, but am unsure how to otherwise access that information in a stable way across multiple methods.

  OOP successes for me in this project include an enigma class under 150 lines, avoiding the security risk posed by using #eval to regain access to my hash in my decrypt.rb CLI file, the use of helper methods to keep each method within its purview of only one responsibility, and the absence of unnecessary class behaviors.

## Ruby Conventions and Mechanics
  I think I scored a 4 here. My classes, methods, and variables are are carefully named for clarity. My syntax and indentation are consistent and clean. My methods are at or under 10 lines apiece. I think my enumerables are well chosen for their respective tasks. I've closely monitored my proram for any dead/trailing whitespaces. I think that my misallocation of @key and @offset (see above) also violate ruby convention, but if I compartmentalize that shortfall into OOP then I feel positively about my ruby convention and mechanics.

## TDD
  I think I scored a 4 here as well. My test coverage metrics show 100% coverage, I stubbed Date.today and enigma.generate_5 in order to return stable results for more thorough testing of randomly (or time-sensitively) generated parts of my code.

## Version Control
  I score myself a 4 here. My project has over 60 commits, I carefully used branching and never pushed to my main branch, and I reviewed and edited each of my pull requests thoroughly before merging.