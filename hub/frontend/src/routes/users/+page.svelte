<script>
import {onMount} from 'svelte'
let name = '';
let password = '';
let organisation = '';
const DEST = import.meta.env.VITE_API_URL
let organisations = [];
let users = [];
async function fetchOrganisations() {
    const response = await fetch(`${DEST}/organisations`);
    const data = await response.json();
    organisations = data;
}
async function fetchUsers() {
    const response = await fetch(`${DEST}/users`);
    const data = await response.json();
    users = data;
}
onMount(async () => {
    fetchOrganisations()
    fetchUsers()
});
const handleSubmit = async () => {
    try {
            const response = await fetch(`${DEST}/users`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'

            },
            body: JSON.stringify({
                name,
                password,
                organisation
            })

        });
        if (!response.ok) {
            throw new Error('Failed to add user');

        }
        alert('User added successfully!');
        name = '';
        password = '';

    } catch (error) {
        console.error(error);
        alert('Failed to add user');

    }

};
</script>
<form on:submit|preventDefault = {handleSubmit}>
<label for="name" > Name: </label>
<input type="text" id = "name"
bind:value={name} required/>
<label for="password" > Password: </label>
<input type="password" id="password" bind:value = { password } required/>
<label>
Organization:
<select bind:value={organisation}> {#each organisations as org} <option value={org.id}> {org.name}</option>
{/each}
</select>
</label>
<ul>
{#each users as user (user.id)}
<li>
<strong>{user.name}
</li>
{/each}
</ul>
<button type="submit">Add User</button></form>
