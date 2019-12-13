abstract type Actions end
struct Pause <: Actions
    ticks::Int
end
