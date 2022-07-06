<script>
  import { getNotificationsContext } from 'svelte-notifications';
  const { addNotification } = getNotificationsContext();

  import Lobby from "./Lobby.svelte";
  import Clues from "./Clues.svelte";
  import Wait from "./Wait.svelte";
  import Guess from "./Guess.svelte";
  import End from "./End.svelte";

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
  {#if game.State === 'lobby'}
    <Lobby ws={ws} game={game} you={you}/>
  {:else if game.State === 'writing'}
    {#if you.IsGuesser}
      <Wait say="Waiting for clues"/>
    {:else}
      <Clues ws={ws} game={game} you={you}/>
    {/if}
  {:else if game.State === 'guessing'}
    {#if you.IsGuesser}
      <Guess ws={ws} game={game} you={you}/>
    {:else}
      <Wait msg="Waiting for guesser"/>
    {/if}
  {:else if game.State === 'end'}
    <End ws={ws} game={game} you={you}/>
  {:else}
    <p>Unexpected game state {game.State}</p>
  {/if}

  <p>Score: {game.Score}/{game.Round}</p>

</main>

<style>
    main {
        text-align: center;
        padding: 1em;
        margin: 0 auto;
    }

    img {
        height: 16rem;
        width: 16rem;
    }

    h1 {
        color: #ff3e00;
        text-transform: uppercase;
        font-size: 4rem;
        font-weight: 100;
        line-height: 1.1;
        margin: 2rem auto;
        max-width: 14rem;
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
