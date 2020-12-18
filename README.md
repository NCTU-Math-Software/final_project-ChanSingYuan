# final_project-ChanSingYuan
final_project-ChanSingYuan created by GitHub Classroom

#### <u>*Problem 10.*</u> *(Dice Game)* ####

Peter has $9$ fair dices with number $\{1, 2, 3, 4\}$, and Colin has $6$ fair dices with $\{1, 2, 3, 4, 5, 6\}$. 
They throw their own dices and calculate the sum of points they get independently.
The event of throwing the dice is independent.
The one with the higher sum wins the game. If they have the same sum, then the game ended in a draw.
What is the probability of Peter win the game? How about the probability of Colin win and draw game?

---

We use the following two method to solve the above problem.

1. ***Probability Method***.
2. ***Statistic Method***.

---

#### <u>*Probability Method.*</u> ####

Considering all the possible outcomes, we directly calculate $P(\mbox{Peter win})$, $P(\mbox{Colin win})$ and $P(\mbox{draw})$.

Let $X$ and $Y$ be the points that Peter and Colin get in the game, respectively.

For $1 \leq i \leq 4$, we define $X_i = \mbox{the number of Peter's dices that have point }i$. Then $0 \leq X_i \leq 9$ for $1 \leq i \leq 4$ and $X = \sum\limits_{i = 1}^4 X_i\cdot i$.

We define the sample space for random vector $(X_1, \ldots, X_4)$ as $\Omega_1 = \{(n_1, \ldots, n_4) \colon\, 0 \leq n_i \leq 9\mbox{ for }1 \leq i \leq 4, \sum\limits_{i = 1}^4 n_i = 9\}$, and define the probability function as $P(X_1 = n_1, \ldots, X_4 = n_4) = \frac{9!}{n_1!\, \cdots n_4!\,}{\big(\frac{1}{4}\big)}^9$.

Similarly, we can define the random variables $Y_j = \mbox{the number of Colin's dices that have point }j$ for $1 \leq j \leq 6$, and the sample space $\Omega_2$ for random vector $(Y_1, \ldots, Y_6)$. Then the probability function is $P(Y_1 = n_1, \ldots, Y_6 = n_6) = \frac{9!}{n_1!\, \cdots n_6!\,}{\big(\frac{1}{6}\big)}^6$.

Note that $P(X = k_1) > 0$ and $P(Y = k_2) > 0$ if $9 \leq k_1 \leq 36$ and $6 \leq k_2 \leq 36$, respectively.

Then, the probability of Peter win is

$\begin{array}{rcll}
P(\mbox{Peter win}) & = & P(X > Y) \\
& = & \sum\limits_{k_1 = 9}^{36}\sum\limits_{k_2 = 6}^{k_1-1} P(X = k_1, Y = k_2) \\
& = & \sum\limits_{k_1 = 9}^{36}\sum\limits_{k_2 = 6}^{k_1-1} P(X = k_1)P(Y = k_2) & \mbox{, since }X\mbox{ and }Y\mbox{are independent.}
\end{array}$

For each $k_1$, $P(X = k_1) = P(\sum\limits_{i = 1}^4 X_i\cdot i = k_1) = \sum\limits_{
\begin{array}{c}
n_1+\cdots+n_4 = 9, 0 \leq n_i \leq 9 \\
n_1\cdot 1+\cdots+n_4\cdot 4 = k_1
\end{array}
} P(X_1 = n_1, \ldots, X_4 = n_4)$ and similarly, for each $k_2$, $P(Y = k_2) = \sum\limits_{
\begin{array}{c}
n_1+\cdots+n_6 = 6, 0 \leq n_j \leq 6 \\
n_1\cdot 1+\cdots+n_6\cdot 6 = k_2
\end{array}
} P(Y_1 = n_1, \ldots, Y_6 = n_6)$.

Similarly, we can calculate the probability $P(\mbox{Colin win})$ and $P(\mbox{draw})$.



Now, we implement the ***probability method*** by the following steps.

> 1. Initialize a list prob_list_PETER with zeros, that used to store $P(X = k)$ in index $k$.
> 2. Define a matrix space_PETER by `multichoose(n, k)` such that each row is a possible $(n_1, \ldots, n_4)$ in $\Omega_1$, the dimension of the matrix space_PETER is $\binom{12}{3}\times 4$.
> 3. For each row in space_PETER, we calculate the probability $P(X_1 = n_1, \ldots, X_4 = n_4)$ and add itnto the index $\sum\limits_{i = 1}^4 = X_i\cdot i$.
> 4. Similiary, do step $(1)$ to $(3)$ for Colin.
> 5. Then we calculate the probability $P(\mbox{Peter win})$ be sum all the probability in the above double summation and similarly for $P(\mbox{Colin win})$ and $P(\mbox{draw})$.



***Result:***

> Probability of PETER win = $0.5731441$
> Probability of COLIN win = $0.3560898$
> Probability of draw = $0.0707662$

---

#### <u>*Statistic Method.*</u> ####

Let $X_1, \ldots, X_n$ be a random sample from $\operatorname{Ber}(p)$, where $p$ is the unknown parameter, denote the probability that Peter win.

Define $\hat{p} = \frac{1}{n}\sum\limits_{i = 1}^n X_i$ be an estimator. Then a $100(1-\alpha)\%$ confidence interval for parameter $p$ is $(\hat{p}-z_{\alpha/2}\sqrt{\frac{\hat{p}(1-\hat{p})}{n}}, \hat{p}+z_{\alpha/2}\sqrt{\frac{\hat{p}(1-\hat{p})}{n}})$, where $z_{\alpha/2}$ satisfies $P(Z > z_{\alpha/2}) = \frac{\alpha}{2}$, $Z$ denote the standard normal distribution.

Similarly, we can find confidence interval for $P(\mbox{Colin win})$ and $P(\mbox{draw})$.



***Result:*** *(Here we set $n = 10^6$ and $\alpha = 0.05$)*

> $95\%$ Confidence interval:
> Confidence interval for probability of PETER win is $(0.5725357, 0.5744743)$
> Confidence interval for probability of COLIN win is $(0.3549316, 0.3568084)$
> Confidence interval for probability of draw is $(0.0701229, 0.0711271)$

---

#### <u>*Remark.*</u> ####

We have an auxiliary function called `multichoose(n, k)`, that given integers $n \geq 0$ and $k \geq 1$, find all possible integers $n_1, \ldots, n_k$ such that $0 \leq n_1, \ldots, n_k \leq n$, and $n_1+\cdots+n_k = n$.

There are $\binom{n-k+1}{k-1}$ possible choices. We return a matrix $A$ with each row is a possible $(n_1, \ldots, n_k)$.

---