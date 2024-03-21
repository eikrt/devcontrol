<script>
import {onMount} from 'svelte'
let name = '';
let port = '';
let orgId = '';
let organisations = [];
let devices = [];
const DEST = import.meta.env.VITE_API_URL
async function fetchOrganisations() {
    const response = await fetch(`${DEST}/organisations`);
    const data = await response.json();
    organisations = data;
}
async function fetchDevices() {
    const response = await fetch(`${DEST}/devices`);
    const data = await response.json();
    devices = data;
}
onMount(async () => {
    fetchOrganisations()
    fetchDevices()
});
const handleSubmit = async () => {
    try {
            const response = await fetch(`${DEST}/devices`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'

            },
            body: JSON.stringify({
                name,
                port,
                orgId
            })

        });
        if (!response.ok) {
            throw new Error('Failed to add device');

        }
        alert('Device added successfully!');
        name = '';
        port = '';
        orgId = '';

    } catch (error) {
        console.error(error);
        alert('Failed to add device');

    }

};
</script>
<form on:submit|preventDefault = {handleSubmit}>
<label for="name" > Name: </label>
<input type="text" id = "name"
bind:value={name} required/>
<label for="port" > Port: </label>
<input type="text" id="portinput" bind:value = { port } required/>
<label>
Organization:
<select bind:value={orgId}> {#each organisations as org} <option value={org.id}> {org.name}</option>
{/each}
</select>
</label>
<button type="submit">Add Device </button></form>
<ul>
{#each devices as dev (dev.id)}
<li>
<strong>{dev.name}
<strong>{dev.port}
<strong>{dev.id}
</li>
{/each}
</ul>
