async function getParticipants() {
    const response = await axios.get("/participants");
    return response.data
}

async function createParticipant(requestObject) {
    const response = await axios.post("/participants", requestObject);
    return response.data
}

async function getDraws() {
    const response = await axios.get("/draws");
    return response.data
}

async function createDraw(count, selectedPeople) {
    const response = await axios.post(`/draws/${count}`, selectedPeople)
    return response.data
}