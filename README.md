# Analysis of eyetracking data from visuospatial planning Task

This code presents an example of a partial analysis of eyetracking data from Gazepoint tracker while participants solve labyrinths (Domic-Siede et al., 2023; adapted to PsychoPy by Erika Orozco and Ariana Fuentes, 2024).

The current code requires that the gazepoint data is the fixations file, that has been appropriately annotated. The annotations required is to have for each fixation, columns that indicate which trial is currently going on, and which phase (planning or execution).

Pending future tasks include:
- [ ] Code to synchronize the gazepoint fixations file with the PsychoPy file for each participant. i.e. that annotates the fixations file.
- [ ] Generalize the code for the new way of automatic annotation.
- [ ] Fix tildes and UTF encoding issues.
- [ ] Code to automatically score for specific behaviors: e.g. regressions on the order of animals.
- [ ] Code to automatically score the PsychoPy behavioral file: that scores the order of animals given verbally by the participant.


# References

Domic-Siede, M., Irani, M., Valdés, J., Rodríguez, M., Follet, B., Perrone-Bertolotti, M., & Ossandón, T. (2023). A Visuospatial Planning Task Coupled with Eye-Tracker and Electroencephalogram Systems. Journal of visualized experiments : JoVE, (193), 10.3791/64622. https://doi.org/10.3791/64622

