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
  <p>
    Write a clue for the guesser to help them guess the word.
    If another player enters the same word, it will be removed.
  </p>

  <p style="margin-bottom: 0">The word the guesser will guess:</p>

  <h2>{game.GuessMe}</h2>

  <fieldset>
    <legend>Your clue</legend>
    <input type="text" bind:value={myClue}>
    <button on:click={submit} style="background: #5e5ea1">Submit Clue</button>
  </fieldset>
</article>
