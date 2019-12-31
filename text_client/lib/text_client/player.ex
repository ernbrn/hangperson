defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used letter, initializing
  def play(%State{tally: %{game_state: :won, letters: letters}}) do
    exit_with_message("YOU WON!\nYour word was: #{letters}")
  end

  def play(game = %State{tally: %{game_state: :lost}}) do
    word = Enum.join(game.game_service.letters)
    exit_with_message("Sorry, you lost!\nThe word was: #{word}")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Sorry, that letter isn't in the word")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_message(game, "You've already used that letter")
  end

  def play(game) do
    continue(game)
  end

  def continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  ## private ##

  defp make_move(game) do
    game
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end
end
