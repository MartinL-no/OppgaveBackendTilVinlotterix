function selectAllOrNone(selectAll) {
    model.inputs.drawPage.selectAll = selectAll;
    for (let person of model.participants) {
      person.isSelected = selectAll;
    }
    updateView();
  }
  
async function addPerson() {
    const requestObject = {
      name: model.inputs.drawPage.newPersonName
    }
    const person = await createParticipant(requestObject);
    model.participants.push({ ...person, isSelected: true });
    updateView();
 }
  
function togglePersonSelected(id) {
    const person = findPerson(id);
    person.isSelected = !person.isSelected;
    updateView();
}
  
async function deletePerson(id) {
    const response = await axios.delete(`/participants/${id}`);
    if (response.status == 200) {
        model.participants = model.participants.filter(p => p.id !== id);
        updateView();
    }
}
  
async function draw() {
    let count = model.inputs.drawPage.drawCount;
    const selectedPeople = model.participants
        .filter(p => p.isSelected)
        .map(p => ({ id: p.id, name: p.name }));
    const draw = await createDraw(count, selectedPeople)
    model.draws.unshift(draw);
    model.app.currentPage = 'winners';
    updateView();
}
  
function changeDrawCount(delta) {
model.inputs.drawPage.drawCount =
    Math.max(1, model.inputs.drawPage.drawCount + delta);
updateView();
}
  
function findPerson(id) {
    return model.participants.find(p => p.id === id);
}