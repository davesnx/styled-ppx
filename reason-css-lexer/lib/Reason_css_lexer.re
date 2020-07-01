include Token;

// TODO: that's definitly ugly
let from_string = string => {
  let buf = Sedlexing.Utf8.from_string(string);
  let rec read = acc =>
    switch (Sedlexing.with_tokenizer(Tokenizer.consume, buf, ())) {
    | (Ok(EOF), _, _) => Ok(acc)
    | (_, start, finish) when start == finish => Error(`Frozen)
    | (value, start, finish) => read([(value, (start, finish)), ...acc])
    };
  read([]);
};
