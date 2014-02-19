structure Parse: sig val parse : string -> unit end =
struct 

structure LambdaLrVals = LambdaLrValsFun (structure Token = LrParser.Token)
structure Lex = LambdaLexFun (structure Tokens = LambdaLrVals.Tokens)
structure LambdaP = Join (
  structure ParserData = LambdaLrVals.ParserData
  structure Lex = Lex
  structure LrParser = LrParser
)

fun parse filename =
    let
        val _ = (ErrorMsg.reset (); ErrorMsg.fileName := filename)
	val file = TextIO.openIn filename
	fun get _ = TextIO.input file
	fun parseerror (s, p1, p2) = ErrorMsg.error p1 s
	val lexer = LrParser.Stream.streamify (Lex.makeLexer get)
	val (parseresult, _) = LambdaP.parse (30, lexer, parseerror, ())
    in
        TextIO.closeIn file
    end 
    handle LrParser.ParseError => raise ErrorMsg.Error

end (* Parse *)
