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
        background: black;
        color: #c7c7c7;
    }
</style>
