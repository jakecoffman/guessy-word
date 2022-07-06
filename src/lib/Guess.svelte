<script>
  export let ws
  export let game = {}

  let myGuess = ''
  function submitGuess() {
    ws.send(JSON.stringify({Type: 'guess', Data: myGuess}))
  }
</script>

<article>
  <h1>Guess</h1>

  <p>Guess the secret word given these clues:</p>

  <ul>
    {#each game.Clues as clue}
      <li>{clue}</li>
    {/each}
  </ul>

  <fieldset>
    <legend>Your Guess</legend>
    <input type="text" bind:value={myGuess}>
    <button on:click={submitGuess} style="background: #a16868;">Submit Guess</button>
  </fieldset>

  <p>Score: {game.Score}/{game.Round}</p>
</article>
