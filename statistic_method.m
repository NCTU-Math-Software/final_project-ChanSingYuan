function statistic_method()
    % Let X_1, ..., X_N be iid random variables, where X_i denotes the indicator function I{PETER win in game i}.
    % Then X_1, ..., X_N is a random sample from Bernoulli(p), where p is unknown parameter, denotes the probability P(PETER win).
    % We find a 100(1-ALPHA)% confidence interval for p.
    % Similarly, we can estimate the probability P(COLIN win) and P(draw).
    % Input: None.
    % Output: P(PETER win), P(COLIN win), and P(draw).

    % Parameters
    num_dice_PETER = 9; % PETER has 9 dices
    max_point_PETER = 4; % outcomes is {1, 2, 3, 4} for each dice of PETER
    num_dice_COLIN = 6; % COLIN has 6 dices
    max_point_COLIN = 6; % outcomes is {1, 2, 3, 4, 5, 6} for each dice of COLIN
    N = 10^6; % sample size
    ALPHA = 0.05; % confidence interval coefficient

    total_win_PETER = 0;
    total_win_COLIN = 0;
    total_draw = 0;
    for ii = 1: N
        % uniformly choose a sample which denotes the points of dices and calculate their scores
        score_PETER = sum(randi(max_point_PETER, 1, num_dice_PETER));
        score_COLIN = sum(randi(max_point_COLIN, 1, num_dice_COLIN));
        if score_PETER > score_COLIN
            total_win_PETER = total_win_PETER+1;
        elseif score_PETER < score_COLIN
            total_win_COLIN = total_win_COLIN+1;
        else
            total_draw = total_draw+1;
        end
    end

    % Interval Estimation
    z_ALPHA_HALF = norminv(1-ALPHA/2);
    sample_prob_win_PETER = total_win_PETER/N;
    sample_prob_win_COLIN = total_win_COLIN/N;
    sample_prob_draw = total_draw/N;
    CI_range_PETER = z_ALPHA_HALF*sqrt(sample_prob_win_PETER*(1-sample_prob_win_PETER)/N);
    CI_range_COLIN = z_ALPHA_HALF*sqrt(sample_prob_win_COLIN*(1-sample_prob_win_COLIN)/N);
    CI_range_draw = z_ALPHA_HALF*sqrt(sample_prob_draw*(1-sample_prob_draw)/N);
    CI_PETER = [sample_prob_win_PETER-CI_range_PETER, sample_prob_win_PETER+CI_range_PETER];
    CI_COLIN = [sample_prob_win_COLIN-CI_range_COLIN, sample_prob_win_COLIN+CI_range_COLIN];
    CI_draw = [sample_prob_draw-CI_range_draw, sample_prob_draw+CI_range_draw];

    % Output
    fprintf('%d%% Confidence interval:\n', 100*(1-ALPHA));
    fprintf('Confidence interval for probability of PETER win is (%.7f, %.7f)\n', CI_PETER(1), CI_PETER(2));
    fprintf('Confidence interval for probability of COLIN win is (%.7f, %.7f)\n', CI_COLIN(1), CI_COLIN(2));
    fprintf('Confidence interval for probability of draw is (%.7f, %.7f)\n', CI_draw(1), CI_draw(2));
end