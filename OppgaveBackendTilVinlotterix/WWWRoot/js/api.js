async function getParticipants() {
    const response = await axios.get("/participants");
    
    return response.data
}

async function getDraws() {
    const response = await axios.get("/draws");
    console.log(response.data)
    return response.data
}