<script>
  export let ws
  export let game = {}
  export let you = {}

  let myClue = ''
  function submit() {
    ws.send(JSON.stringify({Type: 'write', Data: myClue}))
  }
</script>

<article>
  <h1>Clues</h1>
  <p>Write a clue for the guesser to help them guess the word.</p>

  <h2>The word the guesser will guess:</h2>
  <b>{game.GuessMe}</b>

  <fieldset>
    <legend>Your clue</legend>
    <input type="text" bind:value={myClue}>
    <button on:click={submit}>Submit Clue</button>
  </fieldset>
</article>
