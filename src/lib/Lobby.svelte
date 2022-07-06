<script>
  export let ws
  export let you = {}
  export let game = {}

  let newName = ''
  let newGameNumber = ''

  function submit() {
    ws.send(JSON.stringify({Type: 'name', Data: newName}))
  }

  function joinNew() {
    ws.send(JSON.stringify({Type: 'join', Data: newGameNumber}))
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
      {player.Name ? player.Name : "Player " + player.Id}
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

  <a href={location} style="margin-bottom: 1rem">
    {location}
  </a>

  <fieldset style="margin-top: 1rem">
    <legend>Join a Game</legend>
    <input type="number" maxlength="6" bind:value={newGameNumber}>
    <button on:click={joinNew}>Join</button>
  </fieldset>

</article>

<style>
  article {
      max-width: 500px;
      margin: auto;
  }
</style>
