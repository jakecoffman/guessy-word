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
        font-size: 2rem;
        background: black;
        color: #c7c7c7;
    }

    :global(h1) {
        margin: 0 .5rem .5rem;
    }

    :global(ul) {
        list-style: none;
        padding: 0;
        margin: 1rem 0;
    }

    :global(li) {
        padding: 0;
        margin: 0;
    }

    :global(article) {
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    :global(a, a:visited) {
        color: cornflowerblue;
    }

    :global(input) {
        font-size: 16pt;
        padding-top: .5rem;
        padding-bottom: .5rem;
        text-align: center;
        background: #c7c7c7;
        border: none;
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
</style>
