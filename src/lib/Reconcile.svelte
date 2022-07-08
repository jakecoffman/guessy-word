<script>
  export let ws
  export let game = {}
  export let you = {}
  let done = false

  let myClue = ''
  function submit() {
    ws.send(JSON.stringify({Type: 'write', Data: myClue}))
  }

  function toggle(clue) {
    if (done) {
      return
    }
    ws.send(JSON.stringify({Type: 'reconcile', Data: {Text: clue.Text, Dupe: !clue.Dupe}}))
  }

  function ready() {
    ws.send(JSON.stringify({Type: 'ready', Data: !you.IsReady}))
  }
</script>

<article>
  <h1>Dupes</h1>
  <p>
    Check all clues that are the same, or similar to each other, or violate any rules.
  </p>

  <ul style="list-style: none;">
    {#each game.Clues as clue}
    <li>
      <label>
        <input type="checkbox" bind:checked={clue.Dupe} on:click={() => toggle(clue)} disabled={you.IsReady}> {clue.Text}
      </label>
    </li>
    {/each}
  </ul>

  <button on:click={ready}>
    {you.IsReady ? '✅' : ''} I'm Done
  </button>

  <ul>
    {#each game.Players as player}
      <li>
        {player.Name ? player.Name : "Player " + player.Id}
        {you.Id === player.Id ? '(you)' : ''}
        {player.Ready ? '✅' : ''}
        {player.IsGuesser ? '(guesser)' : ''}
      </li>
    {/each}
  </ul>

</article>
