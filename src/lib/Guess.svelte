<script>
  export let ws
  export let game = {}
  export let you = {}

  let myGuess = ''
  function submitGuess() {
    if (myGuess.length === 0) {
      return
    }
    ws.send(JSON.stringify({Type: 'guess', Data: myGuess}))
  }
</script>

<article>
  <h1>Guess</h1>

  <p>Guess the secret word given these clues:</p>

  <ul>
    {#each you.Clues as clue}
      <li>{clue.Text}</li>
    {/each}
  </ul>

  <fieldset>
    <legend>Your Guess</legend>
    <input type="text" bind:value={myGuess} on:keyup={e=>e.key==='Enter' && submitGuess()}>
    <button on:click={submitGuess} style="background: #a16868;">Submit Guess</button>
  </fieldset>

  <p>Score: {game.Score}/{game.Round}</p>
</article>
