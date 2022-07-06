<script>
  export let ws
  export let you = {}
  export let game = {}

  let newName = ''

  function submit() {
    ws.send(JSON.stringify({Type: 'name', Data: newName}))
  }

  function toggleReady() {
    if (you.IsReady) {
      ws.send(JSON.stringify({Type: 'ready', Data: false}))
    } else {
      ws.send(JSON.stringify({Type: 'ready', Data: true}))
    }
  }
</script>

<article>
  <h1>Guessy Word</h1>

  <p>Waiting for 3-7 players to join and ready up</p>

  <ul>
  {#each game.Players as player}
    <li>
      {player.name ? player.name : "Player " + player.Id}
      {you.Id === player.Id ? '(you)' : ''}
      {player.Ready ? '✅' : ''}
    </li>
  {/each}
  </ul>

  {#if !you.IsReady}
    <button on:click={toggleReady} style="margin-bottom: 1rem;">
      Ready Up!
    </button>
  {/if}

  <fieldset>
    <legend>Name yourself</legend>
    <input type="text" maxlength="8" bind:value={newName}>
    <button on:click={submit}>Rename</button>
  </fieldset>

  <p>
    Tell players to join game {location.hash.split('#')[1]} or use this link:
  </p>

  <a href={"http://localhost:3000/" + location.hash}>
    http://localhost:3000/{location.hash}
  </a>

</article>

<style>
  article {
      max-width: 500px;
      margin: auto;
  }
</style>
