signature Lambda_TOKENS =
sig

type token

val LAM: int * int -> string
val DOT: int * int -> string
val LET: int * int -> string
val IN: int * int -> string
val LPAREN: int * int -> string
val RPAREN: int * int -> string
val EQUALS: int * int -> string
val ID: int * int -> string

end
