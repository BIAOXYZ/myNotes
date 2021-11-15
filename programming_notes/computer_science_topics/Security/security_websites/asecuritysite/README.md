
【[:star:][`*`]】 A Security Site https://asecuritysite.com/
- **Quick Jump (Cryptography)**
  * Crypto Pairing https://asecuritysite.com/pairing/
  * Elliptic Curve Cryptography (ECC) https://asecuritysite.com/ecc/
  * Lattice cryptography https://asecuritysite.com/lattice/
  * Post quantum cryptography (PQC) https://asecuritysite.com/pqc/
- **Quick Jump (Others)**
  * Database SQL Analyser: Tutorial 1 (SQL statements) https://asecuritysite.com/database1/db/  【这网站甚至有SQL教程。。。】

# 其他

Ref: William J Buchanan (2021), Network Security and Cryptography (CSN09112), Asecuritysite, from https://asecuritysite.com/csn09112

# https://asecuritysite.com/ecc/

Elliptic Curve Types and nG https://asecuritysite.com/ecc/ecc_types
- > We have a number of possible types of elliptic curve methods. These have a `field` (the prime number used), the `order` (the number of elliptic curve points), an `a` value, a `b` value, and a generator point (`G`). For a ***`Weierstrass curve`*** the standard form is $y^2 = x^3 + ax + b$. With a ***`twisted Edwards curve`*** (such as `Ed25519`) we have the form of $ax^2 + y^2 = 1 + dx^2y^2$. A ***`Montgomory curve`*** has the form of $by^2 = x^3 + ax^2 + x$.

# https://asecuritysite.com/pairing/

Zero-knowledge proof using crypto pairing https://asecuritysite.com/pairing/mir_zk
- > In this case we will use pairing crypto to prove that we know the value of `x` which solves $x^2 + ax + b = 0$. For example if we have $x^2 − x − 42 = 0$ has the solution of $x = 7$ and $x = −6$ as $(x − 7)(x + 6) = 0$.
- > **Background**
  * > First we have two elliptic curves (`G1` and `G2`). Crypto pairs can then be used to prove that Peggy still knows a secret. For this we may have a quadratic equation of: $x^2 − x − 42 = 0$
  * > Then, we will ask Peggy to prove that she knows the value of `x`. In this case, the solution is $x = 7$ or $x = −6$.
  * > Now Peggy has to pass something to Victor to prove that she knows the solution, without giving away the value.
  * > For this we have a point on an elliptic curve of `G`, and use the pairing property of: $e(G,G)^k = 1$
  * > and thus: $e(G,G)^{x^2 − x − 42} = 1$
  * > In pairing this then becomes: $e(G,G)^{x^2} ⋅ e(G,G)^{−x} ⋅ e(G,G)^{−42} = 1$
  * > and which becomes: $e(xG,xG)⋅e(xG,−G)⋅e(G,−42G) = 1$
  * > Peggy will then provide `xG` and Victor will check the pairings multiplied equals unity. If real life `x` will be a large value, and it will ***not be possible to determine `x` from `xG`***.

Cracking Elliptic Curves with the MOV Attack https://asecuritysite.com/pairing/mir_mov
- > **Background**
  * > Now if we select a private key value of `x`, and then the public key will become: $P_{pub} = xP$
  * > In order to find `x`, we would have to search the values of `x` to match `P` to `xP`. In pairing, we can reduce the difficulty with: $e(xP,Q) = e(P,Q)^x$
  * > This now ***becomes a discrete logarithm problem within a finite field***, and which ***makes it easier to find `x`***.
