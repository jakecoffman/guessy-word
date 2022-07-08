<script>
  import Notifications from "svelte-notifications";
  import Game from "./lib/Game.svelte";
</script>

<Notifications>
  <Game/>
</Notifications>

<style>
    :root {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
        Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        font-size: 1.5rem;
        background: black;
        color: #c7c7c7;
    }

    :global(h1) {
        color: #ff3e00;
        text-align: center;
        text-transform: uppercase;
        font-size: 3rem;
        font-weight: 100;
        line-height: 1.1;
        margin: 0 auto;
        max-width: 14rem;
    }

    :global(h2) {
        margin-top: 1rem;
        margin-bottom: 1rem;
    }

    :global(ul) {
        padding: 0;
        margin: 1rem auto;
    }

    :global(li) {
        padding: 0;
        margin: 0 0 .5rem;
        text-align: left;
    }

    :global(article) {
        display: flex;
        flex-direction: column;
        justify-content: center;
        max-width: 500px;
        margin: auto
    }

    :global(a, a:visited) {
        color: cornflowerblue;
    }

    :global(input) {
        font-size: 16pt;
        padding-top: .25rem;
        padding-bottom: .25rem;
        text-align: center;
        background: #c7c7c7;
        border: none;
        border-radius: 5px;
    }

    :global(button) {
        padding: .5rem 2rem;
        font-size: 16pt;
        background: #c7c7c7;
        border: none;
        border-radius: 5px;
    }

    :global(fieldset) {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        border: 1px solid gray;
        border-radius: 5px;
        padding: .5rem;
        margin-left: -.25rem;
    }

    :global(.default-notification-style) {
        font-size: 12pt;
        background: #84c9ec !important;
    }
</style>
