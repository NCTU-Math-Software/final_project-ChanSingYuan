function probability_method()
    % For each possible k, we directly calculate the probability P(PETER's score = k), and
    % similarly calculate the probability P(COLIN's score = k') for each possible k'.
    % Since the above two events are independent for all possible k and k',
    % we can calculate the probabilities of PETER win, COLIN win and draw.
    % Input: None.
    % Output: P(PETER win), P(COLIN win), and P(draw).

    % Parameters
    num_dice_PETER = 9; % PETER has 9 dices
    max_point_PETER = 4; % outcomes is {1, 2, 3, 4} for each dice of PETER
    num_dice_COLIN = 6; % COLIN has 6 dices
    max_point_COLIN = 6; % outcomes is {1, 2, 3, 4, 5, 6} for each dice of COLIN

    % calculate the probability P(PETER's score = k) for each possible k
    prob_list_PETER = zeros(1, num_dice_PETER*max_point_PETER); % the value in index k is the probability P(PETER's score = k)
    % the set of rows (n_1, ..., n_{num_dice_PETER}), ii column represent the number of dices have outcomes ii
    space_PETER = multichoose(num_dice_PETER, max_point_PETER);

    for ii = 1: length(space_PETER)
        score = 0;
        for jj = 1: max_point_PETER % for each row ii, calculate the PETER's score
            score = score+jj*space_PETER(ii, jj);
        end
        % the second term is the probability of row ii occurs
        prob_list_PETER(score) = prob_list_PETER(score) + ...
            factorial(num_dice_PETER)/prod(factorial(space_PETER(ii, : )))*(1/max_point_PETER)^num_dice_PETER;
    end

    % calculate the probability P(COLIN's score = k') for each possible k'
    prob_list_COLIN = zeros(1, num_dice_COLIN*max_point_COLIN);
    space_COLIN = multichoose(num_dice_COLIN, max_point_COLIN);

    for ii = 1: length(space_COLIN)
        score = 0;
        for jj = 1: max_point_COLIN
            score = score+jj*space_COLIN(ii, jj);
        end
        prob_list_COLIN(score) = prob_list_COLIN(score) + ...
            factorial(num_dice_COLIN)/prod(factorial(space_COLIN(ii, : )))*(1/max_point_COLIN)^num_dice_COLIN;
    end

    prob_win_PETER = 0;
    prob_win_COLIN = 0;
    prob_draw = 0;
    % possbile PETER's score is between num_dice_PETER*1 and num_dice_PETER*max_point_PETER
    % possbile COLIN's score is between num_dice_COLIN*1 and num_dice_COLIN*max_point_COLIN
    for ii = num_dice_PETER: num_dice_PETER*max_point_PETER
        for jj = num_dice_COLIN: num_dice_COLIN*max_point_COLIN
            if ii > jj % PETER win
                prob_win_PETER = prob_win_PETER+prob_list_PETER(ii)*prob_list_COLIN(jj);
            elseif ii < jj % COLIN win
                prob_win_COLIN = prob_win_COLIN+prob_list_PETER(ii)*prob_list_COLIN(jj);
            else % draw
                prob_draw = prob_draw+prob_list_PETER(ii)*prob_list_COLIN(jj);
            end
        end
    end

    % Output
    fprintf('Probability of PETER win = %.7f\n', prob_win_PETER);
    fprintf('Probability of COLIN win = %.7f\n', prob_win_COLIN);
    fprintf('Probability of draw = %.7f\n', prob_draw);
end