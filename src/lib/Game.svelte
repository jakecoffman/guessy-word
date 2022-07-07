<script>
  import { getNotificationsContext } from 'svelte-notifications';
  const { addNotification } = getNotificationsContext();

  import Lobby from "./Lobby.svelte";
  import Clues from "./Clues.svelte";
  import Wait from "./Wait.svelte";
  import Guess from "./Guess.svelte";
  import End from "./End.svelte";
  import Reconcile from "./Reconcile.svelte";

  let connected = false
  let initial = true
  let game = {
    Id: '',
    Players: {},
    InGame: false,
    Version: 0,
  }
  let you = {}

  let url;
  if (location.protocol === 'https:') {
    url = 'wss://';
  } else {
    url = 'ws://';
  }
  url += location.host + location.pathname + (location.pathname.endsWith('/') ? 'ws' : '/ws');
  console.log('Connecting to', url)
  const ws = new WebSocket(url)
  ws.onopen = () => {
    connected = true
    initial = false
    console.log('Connected')
    if (location.hash) {
      console.log(location.hash.split('#')[1])
      ws.send(JSON.stringify({Type: 'join', Data: location.hash.split('#')[1]}))
    } else {
      ws.send(JSON.stringify({Type: 'join', Data: ''}))
    }
  }
  ws.onmessage = e => {
    const data = JSON.parse(e.data)
    switch (data.Type) {
      case 'msg':
        console.log(data.Msg)
        addNotification({
          text: data.Msg,
          removeAfter: 4000,
          position: 'bottom-right'
        })
        break
      case 'all':
        location.hash = data.Update.Id
        game = data.Update
        you = data.You
        break
      case 'cookie':
        document.cookie = data.Cookie
        break
      default:
        console.log("Unhandled message", data)
    }
  };
  ws.onerror = e => console.error('error', e);
  ws.onclose = () => connected = false

</script>

<main>
  {#if !connected && initial}
    Connecting...
  {:else if !connected}
    Disconnected, please refresh.
  {:else if game.State === 'lobby'}
    <Lobby ws={ws} game={game} you={you}/>
  {:else if game.State === 'writing'}
    {#if you.IsGuesser}
      <Wait say="Waiting for clues" game={game}/>
    {:else}
      <Clues ws={ws} game={game} you={you}/>
    {/if}
  {:else if game.State === 'reconcile'}
    {#if you.IsGuesser}
      <Wait say="Waiting for clues" game={game}/>
    {:else}
      <Reconcile ws={ws} game={game} you={you}/>
    {/if}
  {:else if game.State === 'guessing'}
    {#if you.IsGuesser}
      <Guess ws={ws} game={game} you={you}/>
    {:else}
      <Wait msg="Waiting for guesser" game={game}/>
    {/if}
  {:else if game.State === 'end'}
    <End ws={ws} game={game} you={you}/>
  {:else}
    <p>Unexpected game state {game.State}</p>
  {/if}

  {#if game.State === 'lobby' || game.State === 'end'}
    <h2>Rules</h2>
    <p>This is a cooperative party game.</p>
    <p>
      Players take turns being the Guesser. The Guesser must guess a
      word given clues from the other players.
    </p>
    <p>
      If players give the same clue, it is deleted. Players may not
      talk about what clue to use. The clue can't be a form of the word.
      The clue must be a word.
    </p>
    <p>
      Not all of these rules are enforced by the system so you
      can choose to have house rules if you like.
    </p>
  {/if}

</main>

<style>
    main {
        text-align: center;
        padding: 1em;
        max-width: 500px;
        margin: 0 auto;
    }

    img {
        height: 16rem;
        width: 16rem;
    }

    p {
        max-width: 14rem;
        margin: 1rem auto;
        line-height: 1.35;
    }

    @media (min-width: 480px) {
        h1 {
            max-width: none;
        }

        p {
            max-width: none;
        }
    }
</style>
