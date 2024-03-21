<script>
import {onMount} from 'svelte'
let name = '';
let password = '';
let organisations = [];
const DEST = import.meta.env.VITE_API_URL
async function fetchOrganisations() {
    const response = await fetch(`${DEST}/organisations`);
    const data = await response.json();
    organisations = data;
    console.log(organisations)
}
onMount(async () => {
    fetchOrganisations()
});
const handleSubmit = async () => {
    try {
            const response = await fetch(`${DEST}/organisations`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'

            },
            body: JSON.stringify({
                name,
            })

        });
        if (!response.ok) {
            throw new Error('Failed to add user');

        }
        alert('Organisation added successfully!');
        name = '';
        password = '';

    } catch (error) {
        console.error(error);
        alert('Failed to add organisation');

    }

};
</script>
<form on:submit|preventDefault = {handleSubmit}>
<label for="name" > Name: </label>
<input type="text" id = "name"
bind:value={name} required/>
<button type="submit">Add Organisation</button></form>
<ul>
{#each organisations as org (org.id)}
<li>
<strong>{org.name}
<strong>{org.id}
</li>
{/each}
</ul>
