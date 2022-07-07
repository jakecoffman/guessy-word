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
    ws.send(JSON.stringify({Type: 'ready', Data: true}))
  }
</script>

<article>
  <h1>Dupes</h1>
  <p>
    Remove all clues that are the same, or similar to each other, or violate any rules.
  </p>

  <ul>
    {#each game.Clues as clue}
    <li>
      <label>
        <input type="checkbox" bind:checked={clue.Dupe} on:click={() => toggle(clue)}> {clue.Text}
      </label>
    </li>
    {/each}
  </ul>

  {#if !you.IsReady}
    <button on:click={ready}>
      I'm Done
    </button>
  {/if}

</article>
