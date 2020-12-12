function A = multichoose(n, k)
    % Given integers n >= 0 and k >= 1, find all possible integers n_1, ..., n_k
    % such that 0 <= n_1, ..., n_k <= n, and n_1 n_1+...+n_k = n.
    % There are nchoosek(n+k-1, k-1) possible choices.
    % We stored each possible (n_1, ..., n_k) in a row in A.
    % Input: A nonnegative integer n, a positive integer k.
    % Output: A nchoosek(n+k-1, k-1)*k matrix A.

    if k == 1 % base case
        A = n;
    else % recursive case, k > 1
        A = zeros(nchoosek(n+k-1, k-1), k);
        r2 = 0;
        for ii = 0: n
            r1 = r2+1;
            r2 = r1+nchoosek(n+k-ii-2, k-2)-1;
            % Given n_1 = ii, column of 2: k is the case of multichoose(n-ii, k-1)
            A(r1: r2, 1) = ii;
            A(r1: r2, 2: k) = multichoose(n-ii, k-1);
        end
    end
end