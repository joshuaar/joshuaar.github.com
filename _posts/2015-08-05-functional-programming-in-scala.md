---
layout: post
category : lessons
tagline: "Functional Programming Features of Scala" 
tags : [programming]
---
{% include JB/setup %}

##Why Functional Programming?

Functional programming is an alternative paradigm with its roots in the [Lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus). It is an old idea (by computing standards) that never got much adoption compared to the imperative languages Java, C++ etc. Today, however, there is an intense revival and interest in functional languages because the paradigm simplifies the process of writing concurrent, highly scalable programs. Functional programming puts artificial restrictions of what you can do with a computer, which make the programs easier to analyze, and limits edge cases. Since functional programming is more a set of restrictions than a set of features, it can be less efficient than imperative styles. In place sorting, for example, is not allowed in a purely functional program.

## Immutability

Immutability is one of the cornerstones of functional programming. This is also the biggest difference in philosophy between Java and Scala. Java is a mutable machine. Most objects have getter and setter methods, arrays are modified in place, etc. After all, the computer at its core is a mutable machine. So why do we care about immutability, and what advantages does it give us?

###Immutability Simplified Concurrent Programming

Functional programmers espouse many reasons to use their paradigm: it produces cleaner, more modular, less error prone code, etc. etc. blah blah. These reasons are not compelling, as it is perfectly possible for a good Java programmer to produce clean reusable error free code. No, functional programming is an old concept in computer science that has received little attention until now. Why the sudden interest?

The reason is that functional programming has a killer feature particularly relevant to modern computing: it greatly simplifies writing concurrent code. Consider the example where we have two threads trying to modify some input:

    public class Counter {
      protected long count = 0;
      public void add(long value){
             this.count = this.count + value;
      }
    }
	
If the add method were called from two different threads, this would cause a race condition. This is because this.count is first read, then modified, creating a [critical section](https://en.wikipedia.org/wiki/Critical_section) in the code.

immutability avoids this problem by simply not allowing this.count to be modified. Every value in functional programming is a final value.

Well, then how do we do all the stuff that requires mutability to work? Well, we use the techniques of functional programming to accomplish the same things while restricting ourselves to immutable data.

### Immutability in Scala

    case class Person(name: String, age: Int)
    
    object MyObject {
      def increaseAge(p: Person) = {
        return p.copy(age = p.age + 1)
      }
    }

Consider Scala's case classes, which are intended to replace Beans or POJOs in Java. They are immutable, so they have no setters. In order to modify their members, we have to create a new object.

##Expressions

Almost everything in Scala is an expression. An expression, unlike a statement, returns a value.

    val i  = 3
    val p = if (i > 0) -1 else -2
    val q = if (true) "hello" else "world"
    
    //p is -1
    //q is "hello"

Loops are also expressions in Scala:

    val x = for( i <- Seq(1,2,3) ) yield i*i
    //x is Seq(1, 4, 9)

Expressions with pattern matching:

    def errorMsg(errorCode: Int) = errorCode match {
      case 1 => "File Not Found"
      case 2 => "Permission Denied"
      case 3 => "Invalid operation"
    }
    println(errorMsg(2))
    //prints "Permission Denied"

##Anonymous Functions

Anonymous functions are a very powerful feature of the language that allows the programmer to treat functions as data.

This example writes two methods, one which squares an integer and the other that takes the sum of squares of two integers.

    object MyObject {
      def sqr(a: Int): Int = a * a
      def sumSquares(a: Int, b: Int): Int = sqr(a) + sqr(b)
    }

This object can be rewritten to use only anonymous functions

    object MyObject {
      val sqr = (a: Int) => a * a
      val sumSquares = (a: Int, b: Int) => sqr(a) + sqr(b)
    }

Anonymous functions are written with the following syntax:

    val myFunc = (arg1: type1, arg2: type2) => {
      //function body goes here
    }

##Higher Order Functions

The ability to pass functions around as values enables the use of higher order functions. A higher order function is a function that either takes a function as arguments, returns a function, or both.

Lets refactor the sumSquares example from above to use higher order functions:

    object MyObject {
      val sqr = (a: Int) => a * a
      val cube = (a: Int) => a * a * a
      
      val sumAny = (f: Int => Int, a: Int, b: Int) => f(a) + f(b)
      val sumSquares = (a: Int, b: Int) => sumAny(sqr, a, b)
      val sumCubes = (a: Int, b: Int) => sumAny(cube, a, b)
    }

the value sumAny is an anonymous, higher order function. It applies the function f to each of its arguments and sums the result. Using this higher order function, we define two lower order functions sumSquares and sumCubes that bind sqr and cube respectively. Lets look in detail at sumAny:

    val sumAny = (f: Int => Int, a: Int, b: Int) = f(a) + f(b)

after the first argument, there is this: Int => Int

This is called a type signature, and it is analogous to a class, only for anonymous function. The higher order function sumAny requires a unary function that takes an integer as an argument and returns an integer. If a function of any other type is given, then the code will not compile.

##Generic Programming/Type Parameters

Type parameters in Scala allow one to define generic functions, methods and classes that work over a range of different types.

    object MyObject {
      def printTheThing[T](thing: T) = println(thing.toString)
      
      printTheThing("hello world")
      printTheThing(1) 
    
      //type parameters are optional when calling
      printTheThing[Int](1)
    }

Notice that the type of the argument is inferred, and the type parameters are inferred, and do not need to be supplied when calling.

##Monadic Types/Operations

What the hell is a monad, anyways? Unfortunately, the people who talk about monads generally use Haskell and are really bad at explaining things to normal well balanced humans. Monads are a simple concept buried in layers of theory.

A Monad has three things:

1. A type constructor
2. a unit function
3. a binding operation

###Type Constructor

In Scala, this just means that the type takes parameters. For example, consider List. Giving it different type parameters produces different lists. This is an example of applying a type constructor.

    object MyObject {
      List[T]
      val ListOfInts = List[Int]()
      val listOfStrings = List[String]()
    }

###Unit Function

A unit function simply takes an object of the underlying type (T in the example above) and creates the corresponding monadic type. Again with the list example, here is an example of applying the unit function:

    object MyObject {
      val nonMonadic = 1
      val monadicList = List[Int](nonMonadic)
      //monadicList is List(1)
    }

###Binding Operation

This is the heart of what a monadic type does. The binding operation is a higher order function (or method) that takes a generic, higher order function as its argument. Here is a signature of a bind operation for the List type:

    object MyObject {
      def bind[T, U](monad: List[T], f: T => List[U]): List[U] = {
        //In Scala, the bind operation is called flatMap, and is a method of every collection
        monad.flatMap(f)
      }
    }

This method takes a List of type T, along with a function that turns a T into a monadic U, and returns a monadic U. This seems complicated, but its just a flatMap. To illustrate the concept, consider the following example of a monad in action:

    object MyObject {
      //A list of integers. This is our monad
      val myMonad = List(1,2,3)
      
      //A function that returns a list of four duplicated integers from a single integer
      val expand = (x: Int) => List(x,x,x,x)
      
      //bind operation aka flatMap
      val result = myMonad.flatMap(expand)
      
      //result is List(1,1,1,1,2,2,2,2,3,3,3,3)
    }

In conclusion, a monadic type is something that can do flatMap, nothing more or less.
Options

##Options

A very handy monadic type available in Scala is the Option. Options are just container types, which may or may not contain a value. You can think of them as Lists that either contain one or none elements.

    object MyObject {
      val x = 1
      val y = null
      val optX = Option(x)
      val optY = Option(y)
      optX.get //returns 1
      optY.get //throws an exception, because the option is empty
    }

Consider the case when we are trying to create some object from two constructor parameters which might be null.

    def instantiateSomething(arg1: SomeObject, arg2: SomeObject): Something = {
      if (arg1 == null)
        return null
      if (arg2 == null)
        return null
      return new Something(arg1.getMember, arg2.getMember)
    }

Here in order to avoid throwing an exception when instantiating Something, we need to check arg1 and arg2 to see if they are null. This can get quite annoying when the number of arguments is large! Consider an alternate version that uses options:

    def instantiateSomething(arg1: Option[SomeObject],
     arg2: Option[SomeObject]): Option[Something] = {
      arg1.flatMap(a1 => arg2.map(a2 => new Something(a1.getMember, a2.getMember)))
    }

Here we have replaced several if/else checks with some monadic operations! This will not throw an exception even if the input options are empty. Lets break this down:

1. The inner map operation over arg2 has this signature Option[SomeObject] => Option[Something].
	This signature returns an optional Something. This option will be empty if its argument a2 is empty, since it is mapping over an empty container.
2. The outer flatMap function only fires if a1 is not empty, and returns an Option[Something] by unpacking the inner option returned by the inner map.

This is getting a little deep and confusing. I suggest you just play around with flatMap and options in Scala to get a better idea of how to use them.
Implicits

##Implicits

Implicits are a nice but often abused feature of Scala. Consider the previous example, where instantiateSomething requires optional SomeObjects. It can be a pain to create these Options by hand, so we can do it implicitly:

    //Define our case classes
    case class SomeObject(getMember: Int)
    case class Something(x: Int, y: Int)
    
    //This requires options, :(
    def instantiateSomething(arg1: Option[SomeObject],
     arg2: Option[SomeObject]): Option[Something] = {
      arg1.flatMap(a1 => arg2.map(a2 => new Something(a1.getMember, a2.getMember)))
    }
    
    //Lets make them implicit
    implicit def someObjectToOption[T](obj: T) = Option(obj)
    
    val a = SomeObject(1)
    val b = SomeObject(2)
    
    //arguments a and b implicitly get optionified
    instantiateSomething(a,b)
    //The above is equivalent to this
    instantiateSomething(someObjectToOption(a), someObjectToOption(b))

Implicits can also be used at the class level. Consider if we wanted to add methods to SomeObject:

    case class SomeObject(getMember: Int)
    
    implicit class GetAnOption(x: SomeObject) {
      def getOption() = Option(x)
    }
    
    val myObj = SomeObject(1)
    myObj.getOption() // returns Option(SomeObject(1))

##Concluding Remarks

Scala has a collection of handy functional features that allow us to deal with immutability in a sane and relatively efficient way. The language has proven itself in scalable systems such as Kafka and Spark, and many of its most important ideas were incorporated into Java 8. As the world moves toward cloud native multi tenent applications in every industry from healthcare to banking, functional concepts will continue to play an important role in making that happen.



















